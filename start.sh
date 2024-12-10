#!/bin/bash

# 设置错误时退出
set -e

# 使用环境变量或默认值
AUTH="${AUTH:-user:pass}"

# 信号处理
trap 'echo "接收到终止信号，正在关闭服务器..."; exit 0' SIGTERM SIGINT

# 启用调试日志
export DUCKDB_HTTPSERVER_DEBUG=1
# 在前台运行
export DUCKDB_HTTPSERVER_FOREGROUND=1

echo "HTTP server started on 0.0.0.0:9999"
# 直接将 SQL 命令传递给 duckdb，而不是创建临时文件
exec /app/duckdb "/data/database.duckdb" -c "
INSTALL httpserver FROM community;
LOAD httpserver;
SELECT httpserve_start('0.0.0.0', 9999, '${AUTH}');" 

