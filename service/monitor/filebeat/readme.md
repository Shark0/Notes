# Filebeat

## 安裝
* [安裝Filebeat](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation-configuration.html)
* 將[filebeat.yaml](filebeat.yml)複製到filebeat資料夾，定義個服務error.log的標籤，並傳到LogStash
* 手動啟動filebeat
```
.\filebeat.exe -e -c filebeat.yml
```