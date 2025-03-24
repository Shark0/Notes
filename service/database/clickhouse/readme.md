# ClickHouse

## Install
### Docker
```
docker run -d -p 8123:8123 -p9000:9000 -e CLICKHOUSE_PASSWORD=root --name clickhouse_example --ulimit nofile=262144:262144 clickhouse
docker stop clickhouse_example
docker rm clickhouse_example
```