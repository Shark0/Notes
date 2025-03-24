# TimescaleDB

## Install
### Docker
```
docker run -d --name example_timescaledb -e POSTGRES_PASSWORD=root -p 5432:5432 -v D:\Shark\Notes\service\database\timescale\postgresql.conf:/var/lib/postgresql/data/postgresql.conf timescale/timescaledb:latest-pg16
docker exec -it example_timescaledb /bin/bash
docker logs example_timescaledb
docker stop example_timescaledb 
docker rm example_timescaledb
```
