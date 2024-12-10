# DuckDB HTTP Server Docker

这是一个运行 DuckDB HTTP 服务器的 Docker 镜像。它提供了一个基于 HTTP 的接口来访问 DuckDB 数据库。

## 功能特点

- 基于 DuckDB v1.1.3
- 支持 HTTP 服务器接口
- 数据持久化存储
- 可配置的端口和认证信息
- 数据目录挂载支持

## 快速开始

### 使用默认配置运行

```bash
docker run -d \
  -p 9999:9999 \
  -v /your/data/path:/data \
  your-image-name
```

### 自定义配置运行

```bash
docker run -d \
  -p 8080:8080 \
  -v /your/data/path:/data \
  -e DUCKDB_PORT=8080 \
  -e DUCKDB_AUTH=myuser:mypassword \
  your-image-name
```

## 环境变量

| 环境变量 | 描述 | 默认值 |
|----------|------|--------|
| DUCKDB_PORT | HTTP 服务器监听端口 | 9999 |
| DUCKDB_AUTH | 认证信息（格式：用户名:密码） | user:pass |

## 数据持久化

数据库文件存储在容器的 `/data` 目录中。要持久化数据，请将主机目录挂载到该路径：

```bash
docker run -d \
  -v /your/data/path:/data \
  your-image-name
```

## 构建镜像

```bash
docker build -t your-image-name .
```

## 访问数据库

服务启动后，可以通过 HTTP 接口访问数据库。例如：

```bash
curl -u user:pass http://localhost:9999/query -d "SELECT 1"
```

## 注意事项

- 请确保在生产环境中修改默认的认证信息
- 数据目录权限设置为 755，确保数据安全性
- 建议使用 Docker 卷或绑定挂载来持久化数据
