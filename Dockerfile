FROM arros/telegram_assistant_env:v1.0.1


# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    ffmpeg \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 复制并安装 Python 依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制整个项目文件
COPY . .

# 创建必要的目录
RUN mkdir -p \
    config \
    downloads/telegram/videos \
    downloads/telegram/audios \
    downloads/telegram/photos \
    downloads/telegram/others \
    downloads/youtube \
    temp/telegram \
    temp/youtube

# 设置脚本权限
RUN chmod +x entrypoint.sh

# 设置环境变量
ENV PYTHONUNBUFFERED=1


ENTRYPOINT ["./entrypoint.sh"]

