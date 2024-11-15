# 依賴反轉

## 單一職責原則
SRP由單一職責原則改成單一修改理由原則，書上講的依賴性是講元件對元件，但我個人覺得依賴性是基於Function對Function，只要Dependcy Function不動到就不會對原有流程有影響，但是當然懂光是在開發過程中動到Class，在Git上就有Git Merge出錯的風險。

但有時如果該Function是權限檢查，一堆API的Domain都有使用到，那其實本來就期待在規則改了以後全部API的權限檢查也更新。因此我覺得依賴關係好壞也要看情境決定。

## 依賴反轉原則
非常認同書上用Repository舉例，但有發現他把Repository Interface放在Domain層。

## 整潔的架構
一開始是事件驅動順序的角度對於Uncle Bob圖畫的Gateway有些誤解，但是他的圖是依賴關係，回應上篇Repository是在Domain層，所以變成Gateway要依賴Repository去實踐Repository Impl。已後端角度來說Controller也算是一個Reuqest Gateway，每個Gateway Function也都有一個唯一修改理由。

在呼應到上一篇依賴反轉，我覺得Repository跟這篇結合應該定定定義Data Gateway，負責應付Database、API、Storage CRUD功能。

## 六角形架構
把六角忽略，重點在Adapter，我覺得他這邊Adapter主要概念跟Adapter Design Pattern很像，Adpater Design Pattern的確同時符合SRP跟OCP，書上的Input/Output Port就是Adpater Interface的Function + Input Dto + Output Dto，再複雜一點可以設計成Adpater搭配Observer Design Pattern。

所以在美好的情境下Impl Function如果都是對各Interface的Function實踐與負責，那的確很漂亮，但全做也可能會很假掰，像是Springboot Controller API的User Dto跟Rquest Dto本來就是要直接丟進某個Service Function來實踐業務邏輯，這時硬切一個Adapter也沒意義，因此要App Framework架構本身找個平衡點。

不過去除程式框架，要能理解我們任何一行代碼都是為了滿足業務邏輯，所以Domain在這篇跟上篇都在正中間絕對是正確的，任何Data、UI都是為了滿足Domain業務邏輯而存在，因此它們在開發關係中是依賴Domain也沒錯。