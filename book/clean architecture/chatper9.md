# 架構之間的對應策略

個人覺得主要看對Domain需要參數 + Web跟Data Source的傳輸是否會浪費，但其實若做Pojo Mapping基本API Service記憶體一定會變多。

## 不對應策略
若是對某個Domain Pojo 基礎的CRUD API個人是支持不對應策略，簡單暴力最好。

##  全對應策略
若有User Login API，通常那種API都不會需要得到User密碼，就可作Web對應。

若有User Info API，通常那種API資料可以透過JPA Projection取得User Info，就可作Datasource對應，對應玩當然一個Pojo直接回傳到Web層。

以上案例讓個人不支持全對應。

## 雙向對應策略
絕對不支持，這篇正好有講到我講的CRUD案例。

## 全部對應策略
這篇主要的案例是透過匯款，基本上就是兩個帳號的金額改變，可以想像Web input command一定是 sourceId + destinationId + money，兩個一定會對datasource的操作command當然是sourceId balance= sourceId balance - money與destinationId balance= destinationId balance - money，這類案例就很適合全對應，甚至不需要Account物件。

## 單向對應策略
雖然他有講好處，但無法與我真的到的經驗Mapping，所以不支持。

## 如何選擇要採用的策略
沒錯，就是視情況而定，你沒有讓我這讀者失望。