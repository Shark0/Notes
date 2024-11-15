# 管理多個Bounded Context

## 為每個Bounded Context建立一個六角形
主要是講都要建port in / out的interface來解耦，就算interface有變更，都改在adapter裡，但其實adapter跟要連接的context也是至少1對1的關係吧? 所以還是要動到相關class。

且真的也無法保證需求變更，每個Context能維持絕對獨立，像是忽然Context要加一個Permission的需求呢? 全部port in DO都要加入Permission或Role參數吧? Adpater也不應該自動生出Permission或Role，所以還是會動到相關Context。

## 解耦合的Bounded Context
看著一個Adapter負責多個port in / out接口，一直在想這也是某種程度的耦合吧? 還是在這耦合就相對好處理?

## 適當耦合的Bounded Context
這個案例題到User Id，我這邊提到我曾經遇過一個案例，看過一個func呼叫了很多sub func，每個sub func都各自在拿user id後去db抓了一次User，這在我眼中是蠻浪費db資源的，後來改成這些Func需要什麼資料，我一開始通通都把每個Func要用的DO通通抓出來，在各自丟進Func中做業務邏輯判斷，依賴性變高但是API反應變快很多倍，所以我從頭到尾都不覺得在複雜的設計中Use Case可以不用知道其他Use的存在。

在退而求其次，先把抓User Do當成一個Sub Use Case，丟近期他Use Case時用Adapter 將Do Map成另一個DTO，但其實記憶體就同時存在一個DO跟DTO，我就覺得這換成另外一個記憶體浪費。
