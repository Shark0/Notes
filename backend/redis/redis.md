# Redis
## Find Keys
* install redis-cli
* input command
```
$ redis-cli -h ${host} -p {port}
$ keys *  
```
## Dump Data
* 安裝複製工具
```
npm install redis-utils-cli -g
```
* 刪除自己電腦的Redis
```
redis-utils del 127.0.0.1:6050 *
```
* 複製
```
redis-utils copy ${source_host}:${source_port}/0 ${source_host}:${source_port}/0 -p *
```