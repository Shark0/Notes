# Elastic Load Balancer
將Client的動態請求分散導到個Instance中，在導入的過程中可以支援以下服務
* Health Check: 檢查各Instance的健康狀況，不健康就不導流
* SSL解密: 讓每個Instance不需要各自解密
* Sticky Session: 根據Session盡量將用戶導到同一台機器上，但還是請後端盡量做到stateless