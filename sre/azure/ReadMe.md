# Azure
開始前建議先將的IP申請成固定IP，原因是很多Service的Security防火牆設定是用ip來判斷

## Resource Group
1. 可以視作一個專案特定環境的資源總集合，在集合建置用來運行專案的服務。
2. 可以用IAM管控專案人員的角色與權限
3. 可以寫ARM範本，將一次要建立的服務建立好
* [官方文件](https://docs.microsoft.com/zh-tw/azure/azure-resource-manager/management/)

## Azure Command Line
透過指令執行AWS服務，方便以後在自動化CI/CD的過程中腳本
* [官方文件](https://docs.microsoft.com/zh-tw/cli/azure/)

### Windows 
* [官方文件](https://docs.microsoft.com/zh-tw/cli/azure/install-azure-cli-windows?tabs=azure-cli)
### Mac
* [官方文件](https://docs.microsoft.com/zh-tw/cli/azure/install-azure-cli-macos)

## Storage Account
儲存/讀取檔案，可搭配CDN建立資源快取節點，目前CDN教學範例多以Blob為主
* [官方文件](https://docs.microsoft.com/zh-tw/azure/storage/)
### Blob
* [官方文件](https://docs.microsoft.com/zh-tw/azure/storage/blobs/)

### File
* [官方文件](https://docs.microsoft.com/zh-tw/azure/storage/files/)

## CDN
根據使用者的地區，設定不同快速讀取檔案的端點，節省檔案傳輸的時間
* [官方文件](https://docs.microsoft.com/zh-tw/azure/frontdoor/)
* [YueTube Blob設定CDN教學](https://www.youtube.com/watch?v=auR9Q8aEF2k)

## Database
### MySql
歷史悠久的資料庫，反正後端現在基本都是MySql、Postgre Sql、Sql Server，可以在Security設定允許的連線IP
* [官方文件](https://docs.microsoft.com/zh-tw/azure/mysql/)

### Redis
歷史悠久的快取資料庫，可以在Security設定允許的連線IP
* [官方文件](https://docs.microsoft.com/zh-tw/azure/azure-cache-for-redis/)

## Virtual Machine
可以打開Windows跟Linux兩種虛擬機，在上面灌想要的服務，可以在Security設定開放的Port以及允許的連線IP
* [官方文件](https://docs.microsoft.com/zh-tw/azure/virtual-machines/)

## AKE
Azure K8s服務，讓你建置集群，以及在上面部署專案
* [官方文件](https://docs.microsoft.com/zh-tw/azure/aks/)

## Virtual Network
網路設定很重要的一環，其中Security Group不同服務開放的PORT以及對像
* [官方文件](https://docs.microsoft.com/zh-tw/azure/virtual-network/)
* [CIDR Wiki](https://zh.wikipedia.org/zh-tw/%E6%97%A0%E7%B1%BB%E5%88%AB%E5%9F%9F%E9%97%B4%E8%B7%AF%E7%94%B1)

## 監控
監控上述服務資源負載
* [官方文件](https://docs.microsoft.com/zh-tw/azure/azure-monitor/)

## ARM範本
將一個資源群組裡需要的服務寫在一個腳本裡，需要的時候一次建立出全部的服務
* [官方文件](https://docs.microsoft.com/zh-tw/azure/azure-resource-manager/templates/)

## Cost Manager
評估全部資源消耗的費用，可以設定預算跟警示通知，避免預算爆炸。
* [官方文件](https://docs.microsoft.com/zh-tw/azure/azure-resource-manager/templates/)