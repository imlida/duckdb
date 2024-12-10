FROM debian:bookworm-slim

# 设置工作目录
WORKDIR /app

# 安装必要的工具
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 创建数据目录
RUN mkdir -p /data && chmod 755 /data

# 声明数据卷
VOLUME ["/data"]

# 下载并安装DuckDB到/app路径
RUN wget https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-amd64.zip \
    && unzip duckdb_cli-linux-amd64.zip -d /app \
    && rm duckdb_cli-linux-amd64.zip \
    && chmod +x /app/duckdb

# 复制启动脚本和配置文件
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# 暴露默认端口
EXPOSE 9999

# 设置容器启动命令
ENTRYPOINT ["/app/start.sh"] 