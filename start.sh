#!/bin/bash

# 设置错误时退出
set -e

# 使用环境变量或默认值
AUTH="${AUTH:-user:pass}"

# 信号处理
trap 'echo "接收到终止信号，正在关闭服务器..."; exit 0' SIGTERM SIGINT

# 创建临时SQL文件
cat > /app/duckdb-server.sql << EOF
INSTALL httpserver FROM community;
LOAD httpserver;
CALL httpserve_start('0.0.0.0', 9999, '${AUTH}');

-- 保持服务器运行
SELECT CASE WHEN 1=1 THEN NULL END FROM range(9999999999);
EOF

echo "正在启动 DuckDB HTTP 服务器在端口 9999..."
exec /app/duckdb "/data/database.duckdb" -init /app/duckdb-server.sql 