#High Concurrency
最近處理高併發連線請求，把我處理碰到的技術克服點的心得大概寫寫，有興趣的人就看看

## Sql Service
跟SRE有關，但如果在一家SRE很弱的公司後端工程師還是要有一點概念

### Connection Pool
Connection Pool少就代表不同服務在操作Database要排隊，要改config裡的connection & thread size，以及在server的open file數量。

### Table Write & Read效能
跟硬碟IO有絕對關係，硬體IO次數越少笑能越快，就看一些Buffer跟Trx Commit要怎麼設定，想辦法把Memory配好配滿。

## Table
### Index
基本上就是避免執行的Query Sql在Explain裡面是Full Scan，有吃到Index就是快。

### Partition
避免一張表太大，可以預先用hash id先搞出多張子表，一張表資料越少代表效能越好。

## Jdbc
### Max Connection Pool
Connection Pool少就代表API Request 在執行Sql要排隊，可以根據Tomcat Max Connection做1:1的配置，反正1個connection的worker thread就是會操作db，有其他multithread的情境再額外根據其他async task的thread pool大小作調整。

### Idle Connection Pool
備戰單位，個人是先設定1/2個Max Connection，但其實內心是想要設定1:1，但目前沒看過半個網路文章是設定1:1。

## Tomcat
### Max Connection
連線最大的請求數，要根據Jmeter壓測時來根據Response Time & CPU & Memory做調整。 做好的結果就是在最大連線請求下，Response Time維持在300毫秒以下，但是CPU跟Memory已經用了80%。

### Thread
NIO的機制是一個Thread可以應付多個Connection，但是就我的觀念還是設定1:1，讓Worker的數量跟請求的數量保持一至，若有其他有multi-thread的情境再額外根據其他async task的thread pool大小做調整。

## K8s
一個人打不贏就烙人，就是後端的精隨，但是把烙人的條件跟成本管控好，就是後端的功力。

### HPA
minReplicas看上版時間，如果是在沒甚麼用戶時間上板的話可以設定成1，但是如果是在一般時間就要上，minReplicas = (用戶請求數 /pod最大連線數 + 1)，cpu跟memory的averageUtilization設定成70%，別浪費時間算得剛剛好，重點服務不要出錯就好。