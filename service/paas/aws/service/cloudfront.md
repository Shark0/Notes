# Cloudfront
AWS CDN的服務之一，提供網站內容的鏡像站，解決靜態資源的高流量。
* 在網路各區建立Distribution
* 每個Distribution裡有多個Edge Location
* 當用戶向Cloudfront索取資源時，Cloudfront會根據用戶區域決定要用哪個Distribution，若有DDOS可以根據攻擊者特徵做限制
* 若Edge Cache裡有資源，會直接回傳給Client，若沒有會透過OAI的方式取得[S3](s3.md)跟[EC2](ec2.md)的資源。