#!/bin/bash

# 使用环境变量或默认值
PORT="${DUCKDB_PORT:-9999}"
AUTH="${DUCKDB_AUTH:-user:pass}"

# 创建临时SQL文件
cat > /app/temp-server.sql << EOF
INSTALL httpserver FROM community;
LOAD httpserver;
SELECT httpserve_start('0.0.0.0', ${PORT}, '${AUTH}');
EOF

# 启动DuckDB
exec /app/duckdb "/data/database.duckdb" -init /app/temp-server.sql 