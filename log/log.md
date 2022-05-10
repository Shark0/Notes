#log
## Level 
* Debug: 開發用的Log，方便用來debug，像是去db query的sql
* Info: 一般追查用的Log，像是什麼時間、誰、做了甚麼事、帶了那些參數，應付PM提問
* Warn: 警告追查用的Log，像是什麼時間、誰、做了甚麼不應該做的事、帶了那些參數
* Error: 非預期系統錯誤Log

## Setting Trace Id
方便追查一個api在該thread運行的全部流程
### log4j2
還可以將trace id透過header回傳給前端，方便debug用
* https://blog.csdn.net/qq_39529562/article/details/107943739

### log4net
感覺蠻弱的
* https://docs.datadoghq.com/tracing/connect_logs_and_traces/dotnet/?tab=nlog

## Parser Log
### Command
Print lines within a particular time range and keyword
```
awk '/${start_time}/,/${end_time}/ { if (/${keyword}/) print }' '${log_file}}'
```
example
```
awk '/2022-02-28 16:49:/,/2022-02-28 16:51:/ { if (/StartWcfServer/) print }' '5 error.log'
```
上方指令在範例有個問題，就是如果沒有2022-02-28 16:49或2022-02-28 16:51 這些Log，會找不到Log，
所以建議先找某天某個小時的時間區段開始，像是
```
awk '/2022-02-28 16:/,/2022-02-28 16:/' '5 error.log'
```

## SRE[斗星轉移](https://www.newton.com.tw/wiki/%E6%96%97%E8%BD%89%E6%98%9F%E7%A7%BB)
自動回報Log建置，若有非預期Error Log產生，立即自動打到聊天室通知後端修Bug
### Telegram Bot
* [申請Telegram Bot，測試訊息發送](https://ithelp.ithome.com.tw/m/articles/10262881)
* [Telegram Post方式發送訊息](https://ithelp.ithome.com.tw/articles/10247561)

### Filebeat 
* [安裝Filebeat](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation-configuration.html)
* 將[filebeat.yaml](filebeat/filebeat.yml)複製到filebeat資料夾，定義個服務error.log的標籤，並傳到LogStash
* 手動啟動filebeat
```
.\filebeat.exe -e -c filebeat.yml
```

### LogStash
* [安裝LogStash](https://www.elastic.co/guide/en/logstash/current/running-logstash-windows.html)
* 將[pipelines.yaml](./logstash/pipelines.yml)複製到Logstash的config資料夾，指定用api.conf處理事件串流
* 修改config/logstash.yml配置，設定api.http.host: 127.0.0.1 跟 api.http.port: 9600
* 將[api.conf](./logstash/api.conf)複製到config資料夾，根據各事件串流的標籤呼叫telegram bot傳送訊息到聊天群
* 手動啟動LogStash
```
.\bin\logstash.bat
```





