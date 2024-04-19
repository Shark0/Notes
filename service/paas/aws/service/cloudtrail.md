# CloudTrail
監控雲端服務操作行為
![image](image/cloudtrail.webp)

* 將用戶操作AWS Resource Log寫入[S3](s3.md)
* 透過[Cloud Watch](cloudwatch.md)讀取S3的Log檔，透過Metrics視覺或圖表
* 若有要立即通知的事件，可以設定Alarm的條件搭配[SNS](sns.md)服務傳送訊息給Admin