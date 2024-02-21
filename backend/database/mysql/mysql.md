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
這裡要看trx_tables_in_use，盡量保持1

* 生成砍掉事務線程指令
```
select concat('KILL ',id,';') from information_schema.processlist p inner join information_schema.INNODB_TRX x on p.id=x.trx_mysql_thread_id where db='test';
```

## 效能優化
### Doc
* https://xie.infoq.cn/article/a274e214af9b43f77119b1d90
* https://www.cnblogs.com/Sol-wang/p/17076128.html
* https://blog.csdn.net/eagle89/article/details/128429971

### Config
/etc/my.inf
* max_connections=16364
* thread_cache_size=1024
* innodb_buffer_pool_size=16G
* innodb_buffer_pool_instances=16
* innodb_read_io_threads=64
* innodb_write_io_threads=128
* key_buffer_size=1G
* innodb_io_capacity=1000
* innodb_io_capacity_max=4000
* innodb_redo_log_capacity=1G
* open_files_limit=8192
* table_open_cache=8192
* table_open_cache_instances=32
* innodb_flush_log_at_trx_commit=2
* sync_binlog=0
* read_buffer_size=1G
* join_buffer_size=1G
* sort_buffer_size=1G
* max_allowed_packet=16M
* net_buffer_length=32M
* innodb_log_file_size=1G
* innodb_log_buffer_size=1G
* max_allow_packet=1G