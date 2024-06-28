# Route 53

AWS提供的DNS服務

## DNS格式

| 格式       | 敘述                   |
|----------|----------------------|
| A Record | 將一個域名對應到ELB或Instance |
| CName    | 將一個域名對應到另一個域名        |
| Alias    | 將一個域名對應到一個頂級域名       |

## Routing Policy

| Policy       | 敘述                               |
|--------------|----------------------------------|
| Simple       | 將一個域名透過單純的路由決策對應到單個資源            |
| Weighted     | 將一個域名透過每個資源配置的權重發送不同的流量比例        |
| Multivalue   | 將一個域名透過單純的路由決策對應到多個資源            |
| Geolocation  | 將一個域名透過用戶地區對應到配置該地區的資源           |
| Geoproximity | 將一個域名透過用戶地區對應到最靠近該地區的資源          |
| Latency      | 將一個域名對應到對User延遲最低的資源             |
| Failover     | 將一個域名可以判斷主透過主配置是否可用，不可用時將流量倒到次配置 |