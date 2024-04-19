# CloudFormation
AWS提供用戶快速配置Resource的服務，用戶可以按照一下步驟建置Resource
* 透過CloudFormation Designer設計需求要用到的AWS Resource
* 設計完後生產出CloudFormation Template
* 微調Template裡面的Stack，並要注意服務之前有沒有相依性，有的化要設定Depend On或Wait Condition
* 讓AWS根據Template部屬
* 每次Template變更，AWS會將變更內容存在Change Set

