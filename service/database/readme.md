# Database

## RDB

* [Mysql](mysql/readme.md)
* PostgreSQL

## Key - Value

* [Redis](redis/redis.md)

## Document

* Mongo

## Column

* Cassandra
* Scylla
* HBase

## Graph

* Neo4j

## Cache

* [AWS Elasticache](../paas/aws/service/elasticache.md)

## TFIDF

* Elasticsearch

## Compare

| 特性     | 	MySQL         | 	Redis                  | Elastic Search       |
|--------|----------------|-------------------------|----------------------|
| 資料模型	  | 關係型（表格、行、列）    | 	鍵值型（支援多種資料結構）          | 非結構化/半結構化（JSON）      |
| 儲存方式	  | 磁碟（支援記憶體表）     | 	記憶體（支援磁碟持久化）           | 磁碟（支援記憶體表）           |
| 查詢語言   | 	SQL	          | 無 SQL，自定義命令（如 GET/SET）  | Query DSL / REST API |
| 效能     | 	高（複雜查詢較慢）     | 	極高（簡單操作，微秒級延遲）         | 高吞吐量搜尋，分散式強          |
| 事務支援   | 	支援 ACID 事務	   | 有限（MULTI/EXEC 簡單事務）     | 不支援                  |
| 資料結構   | 	結構化（表格）	      | 鍵值、列表、集合、雜湊、排序集等        | 非結構化/半結構化（JSON）      |
| 持久化    | 	強（磁碟儲存，預設持久）	 | 可選（RDB 快照或 AOF 日誌）      | 強（磁碟儲存，預設持久）         |
| 擴展性    | 	中等（主從複製、分片）   | 	高（分散式架構，Redis Cluster） | 水平擴展，分散式             |
| 主要應用場景 | 	企業應用、結構化資料管理	 | 快取、會話管理、即時分析            | 日誌分析、搜尋引擎            |
