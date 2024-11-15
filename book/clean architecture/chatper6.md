# 網路層轉接器實做

## 依賴反轉
這篇用Websockt來舉例一開是有轉接器的好處，但我覺得這是為了辯贏的爛舉例，原因如下

* 有幾個Service會在有Controller之後有Websockt? 
* 就算Controller與Service之間沒有port.in的interface，難道Websocket不能自己額外做一個port.in的adapter interface? 
* adpater的精神來自現實中的插座頭與插座孔，但現世生活中也是只有有需要時才會用轉接器

別為了少數就要多數配合阿…

## 網頁層轉接器的職責
很多職責在Springboot裡Web層已經做了

## 分割開來的控制器
感覺這篇有點走火入魔，沒必要把Controller分的跟Use Case這麼細，已代碼角度我會這樣定義
* Controller - 一個Domain Service的集合 
* Use Case Service - 列舉一個Domain有哪些Use Case，像是基礎的CRUD Service 
* Use Case Helper - Use Case間會共用的邏輯，讓小幫手統一完成