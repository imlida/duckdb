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

# 创建临时SQL文件
cat > /app/duckdb-server.sql << EOF
INSTALL httpserver FROM community;
LOAD httpserver;
SELECT httpserve_start('0.0.0.0', 9999, '${AUTH}');
EOF

echo "正在启动 DuckDB HTTP 服务器在端口 9999..."
exec /app/duckdb "/data/database.duckdb" -init /app/duckdb-server.sql 