# 儲存層轉接器實作
我會用Data Source的角度看待儲存層

## 依賴反轉
考量以下種種情境
* Unit Test連不上資料環境的Mock Data建置
* Spring JPA基本框架就支援
* 真的有遇到拿資料從API改成FTP

所以我在取得資料那一層是支持Interface概念，而Adapter就是實踐Interface向Data Sources拿資料。

## 儲存層的轉接器的職責
完全支持，有些Datasource是已知存在，pojo之間當然要做轉化，但是有時候要考量如何不要讓一個pojo在helper之間被呼叫多次，增加datasource loading 以及 service 效能。

## 分割開來的轉接阜的介面
支持，越簡單越好。

## 分割開來的儲存層轉接器
跟JPA一樣，JPA是用Table來區分。

## 以Spring Data JPA為例
這篇章節的Pojo轉換用Mapper真的很容易讓人誤會成Mybatis的Mapper欸… 不過現階段也沒有一定要分用Mybatis不可的理由。

P.S. 我不覺得一定要將Do Map成Dto。

## 資料庫交易的問題
必要的髒，沒辦法