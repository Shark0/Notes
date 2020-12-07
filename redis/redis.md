# Redis
## Find Keys
* install redis-cli
* command
```
$ redis-cli -h ${host} -p {port}
$ keys *  
```
# Dump Data
reference: https://programmer.ink/think/several-ways-to-export-and-import-redis-data.html
* install redis dump
* command 
```
$ redis-dump -u {host1}:${port} > data.json
# redis-dump -u :{password}@{host1}:${port} > data.json
$ < redis_data.json redis-load -u ${host2}:{port}
```
