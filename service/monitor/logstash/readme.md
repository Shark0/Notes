# Logstash

## 安裝
* [安裝LogStash](https://www.elastic.co/guide/en/logstash/current/running-logstash-windows.html)
* 將[pipelines.yaml](pipelines.yml)複製到Logstash的config資料夾，指定用api.conf處理事件串流
* 修改config/logstash.yml配置，設定api.http.host: 127.0.0.1 跟 api.http.port: 9600
* 將[api.conf](api.conf)複製到config資料夾，根據各事件串流的標籤呼叫telegram bot傳送訊息到聊天群
* 手動啟動LogStash
```
.\bin\logstash.bat
```