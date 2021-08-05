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

### Install & Start api service
* 用SpringBoot為ELK範例寫的API Service，整個Service裡面有加、減、乘、除四個API，每次Request都會有info.log
* 除的API只要value2等於0就會出錯並產生error.log

#### install
```
cd ~
git clone -b feature/elk https://github.com/Shark0/SpringBootExample.git
cd SpringBootExample
mvn clean package -DskipTests 
```

#### create api.service
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
#### start api service
```
systemctl daemon-reload
systemctl enable api.service
systemctl start api
```
#### open swagger
```
http://127.0.0.1:8080/swagger-ui.html
```

#### tail log
```
tail -n 200 /var/log/SpringBootExample/info.log
tail -n 200 /var/log/SpringBootExample/error.log
```

### Install & Start elasticsearch
#### install
```
https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html
```
#### edit elasticsearch config
```
vi /etc/elasticsearch/elasticsearch.yml
```
[content](./elasticsearch/elasticsearch.yml)

#### edit elasticsearch jvm config 
```
vi /etc/elasticsearch/jvm.options
```  
[content](./elasticsearch/jvm.options)

#### start elasticsearch
```
systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch
```

### Install & Start kibana
#### install
```
https://www.elastic.co/guide/en/kibana/current/rpm.html
```
#### edit kibana config
```
vi /etc/kibana/kibana.yml
```
[content](./kibana/kibana.yml)

#### start kibana
```
systemctl daemon-reload
systemctl enable kibana.service
systemctl start kibana
```

### Install & Start logstash
#### install
```
https://www.elastic.co/guide/en/logstash/current/installing-logstash.html
```
#### edit logstash config
```
vi /etc/logstash/logstash.yml
```
[content](./logstash/logstash.yml)

#### edit logstash pipeline 
```
vi /etc/logstash/pipelines.yml
```  
[content](./logstash/pipelines.yml)

#### edit pipeline config
filebeat會將不同的log來源標記不同的tag，logstash根據不同的tag做出不同的filter，將log產生時間以及發生的class.method抓出來產生新的filed，並根據寫進不同的index，方便kibana設定不同的index pattern，並將不同的index pattern做出不同的報表 
```
vi /etc/logstash/conf.d/api.config
```
[content](./logstash/conf.d/api.conf)

#### edit logstash jvm config
```
vi /etc/logstash/jvm.options
```  
[content](./logstash/jvm.options)

#### start logstash
```
systemctl daemon-reload
systemctl enable logstash.service
systemctl start logstash
```

### Install & Start filebeat
#### install
```
https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation-configuration.html
```
#### edit logstash config
將不同的log來源定義不同的tag，讓logstash有能力根據不同的log處理filter
```
vi /etc/filebeat/filebeat.yml
```
[content](filebeat/filebeat.yml)

## Test ELK
建立一個月內API Info長條圖、建立一周內API Error長條圖
### 產生Log
* 呼叫除法api讓他出錯產生info.log跟error.log資料
```
curl -X POST "http://localhost:8080/math/divide" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"value1\": 1, \"value2\": 0}"
```
### 設定index pattern
* 前往Kibana [Dev Tool](http://127.0.0.1:5601/app/dev_tools#/console) 搜尋index 
* 輸入下方指令搜尋有沒有名為api_info-${date}跟的index，有的話代表配置成功
```
GET /_cat/indices
```
* 設定Kibana Index pattern
  * 點擊左選單Management的[Stack Management](http://127.0.0.1:5601/app/management)
  * 點擊左侧[Index Pattern](http://127.0.0.1:5601/app/management/data/index_management)
  * 新增"api_info*" Index Pattern
  * 新增"api_error*" Index Pattern

* 點擊左選單Analytics的Dashboard
  
* 建立一個月內API使用長條圖在Kibana Dashboard
  * 點擊"Create visualization"
  * 選擇上方圖表為"Bar vertical"
  * 選擇右上方時間為"1 Month ago"
  * 選擇右方index pattern為"api_info*"
  * 拖拉左方"classMethod.keyword"到正中間
  * 點擊右上"Save and return" 

* 建立一周內API錯誤Table在Kibana Dashboard
  * 點擊"Create visualization"
  * 選擇上方圖表為"Table"
  * 選擇右上方時間為"1 Month ago"
  * 選擇右方index pattern為"api_error*"
  * 拖拉左方"_id"到正中間
  * 拖拉左方"_index"到正中間
  * 拖拉左方"classMethod.keyword"到正中間
  * 點擊右上"Save and return"
* 點擊上方Save

## Next
* 研究Kibana Alert功能