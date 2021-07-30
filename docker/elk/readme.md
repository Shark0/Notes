# ELK
kibana (ui) + elasticsearch (database) + logstash (log filter) + filebeat (log shipper)，demo將api log透過filebeat傳到elasticsearch資料庫

## build container
docker run --privileged=true -itd  --name=elk -p 5601:5601 -p 8080:8080 centos/systemd /sbin/init

* port
    * 5601: kibana
    * 8080: springboot web api

## Install Service

### Init
* install
```
yum update -y
yum install git -y
yum install wget -y
yum install perl-Digest-SHA -y
yum install java-11-openjdk-devel -y
yum install maven -y
yum install net-tools -y
```

## Install & Start api service
這是我用SpringBoot為ELK範例寫的API Service，整個Service裡面有加、減、乘、除四個API，正常操作都會有info.log，但在除的API只要value2等於0就會出錯並產生error.log

* install
```
cd ~
git clone -b feature/elk https://github.com/Shark0/SpringBootExample.git
cd SpringBootExample
mvn clean package -DskipTests 
```

* create api.service
```
vi /lib/systemd/system/api.service
```
service content
```
Description=api
After=syslog.target

[Service]
ExecStart=/usr/lib/jvm/java-11-openjdk/bin/java -jar /root/SpringBootExample/target/SpringBootExample.jar

[Install]
WantedBy=multi-user.target
```
* start api service
```
systemctl daemon-reload
systemctl enable api.service
systemctl start api
```
* open swagger
```
http://127.0.0.1:8080/swagger-ui.html
```
  
* tail log
```
tail -n 200 /var/log/SpringBootExample/info.log
tail -n 200 /var/log/SpringBootExample/error.log
```

### Install & Start elasticsearch
* install
```
https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html
```
* edit elasticsearch config
```
vi /etc/elasticsearch/elasticsearch.yml
```
content
```
cluster.name: elk
node.name: node-1
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: 0.0.0.0
http.port: 9200
discovery.type: single-node
```
* edit elasticsearch jvm config 
```
vi /etc/elasticsearch/jvm.options
```  
content
```
-Xms256m
-Xmx256m
```
* start elasticsearch
```
systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch
```

### Install & Start kibana
* install
```
https://www.elastic.co/guide/en/kibana/current/rpm.html
```
* edit kibana config
```
vi /etc/kibana/kibana.yml
```
content
```
server.port: 5601
server.host: "0.0.0.0"
server.name: "elk"
elasticsearch.hosts: ["http://127.0.0.1:9200"]
kibana.index: ".kibana"
kibana.defaultAppId: "home"
```

* start kibana
```
systemctl daemon-reload
systemctl enable kibana.service
systemctl start kibana
```

### Install & Start logstash
* install
```
https://www.elastic.co/guide/en/logstash/current/installing-logstash.html
```
* edit logstash config
```
vi /etc/logstash/logstash.yml
```
content
```
http.host: "0.0.0.0"
http.port: 9600
```
* edit logstash pipeline 
```
vi /etc/logstash/pipelines.yml
```  
content
```
- pipeline.id: api
  path.config: "/etc/logstash/conf.d/api.conf"
```

* edit pipeline config
```
vi /etc/logstash/conf.d/api.config
```
content
```
input {
    beats {
        port => 5044
    }
}

output {
    elasticsearch {
        index => "api-%{+YYYY.MM.dd}"
        hosts => "127.0.0.1:9200"
    }
}
```

* edit logstash jvm config
```
vi /etc/logstash/jvm.options
```  
content
```
-Xms256m
-Xmx256m
```

* start logstash
```
systemctl daemon-reload
systemctl enable logstash.service
systemctl start logstash
```

### Install & Start filebeat
* install
```
https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation-configuration.html
```
* edit logstash config
```
vi /etc/filebeat/filebeat.yml
```
content
```
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/SpringBootExample/*.log
  multiline.pattern: ^\[
  multiline.negate: true
  multiline.match: after

output.logstash:
  hosts: ["127.0.0.1:5044"]
```

## Test ELK
* 呼叫除法api讓他出錯產生info.log跟error.log資料
```
curl -X POST "http://localhost:8080/math/divide" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"value1\": 1, \"value2\": 0}"
```
* 前往Kibana [Dev Tool](http://127.0.0.1:5601/app/dev_tools#/console) 搜尋index 
* 輸入下方指令搜尋有沒有名為api-${date}的index，有的話代表配置成功
```
GET /_cat/indices
```
* 找看看error log
```
POST api-${date}/_search
{
  "query": {
    "match": {
      "log.file.path": "/var/log/SpringBootExample/error.log"
    }
  }
}
```

## Next
* 研究Kibana Discover功能
* 研究Logstash Filter功能
* 研究Elasticsearch Query功能