# Mysql

## Dump Data 
* Use Datagrip export
    * right click database 
    * click 'Export with mysqldump'
* command import
```
mysql -u ${user_name} -p${password} < data.sql
``` 

## Lock
* 全局鎖
* 表級鎖
  * 表鎖table lock: alter table時發生
  * 元數據鎖 metadata lock
    * 對表作增刪改查: 讀鎖
    * 對表結構做邊更: 寫鎖
* 行鎖

## 處裡Table Lock
* 查詢正在使用的表
```
show open tables where in_use > 0 ;
```
* 查詢紀錄線程
```
show processlist;
show full processlist;
```
* 查詢當前所有運行的事務
```
select * from information_schema.INNODB_TRX;
```
* 查詢當前出現的鎖
```
select * from information_schema.INNODB_LOCK_waits;
```
* 生成砍掉事務線程指令
```
select concat('KILL ',id,';') from information_schema.processlist p inner join information_schema.INNODB_TRX x on p.id=x.trx_mysql_thread_id where db='test';
```