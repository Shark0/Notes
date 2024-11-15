# 階層式架構的問題點
階層式架構
## 書上的接層式架構為
* Web
* Domain
* Persistence

我個人認為應該改成
* Web
* Domain
* Data Source

因為其實Domain在觸裡邏輯過程中資料的來源不是只有Database，也有來自API、Queue、Storage等系列的服務

## 資料驅動設計
首先我不認為Domain層直接用Datasource Response的DO是髒的，基本上只要DO的資料不要改變型態、欄位不要減少，是不會影響原有的Domain，所以也不需要太過於擔心耦合，且Update Data Service基本都要找到DO更新內容後回存。

當然是可以理解Service層的Function要運作的資料改成專屬DTO，且將DO轉換成DTO的邏輯寫在Datasource區塊中可以大幅降地之後Domain層被修改的機會，但是不管甚麼情境都強制規定用Map Struct做物件轉換會不會有種為賦新詞強說愁的假掰感?

我個人覺得如果Datasource DO跟Domain DTO的資料是一模一樣是沒必要硬轉，像是用JPA Projection方法取得的資料大部分情境就是一模一樣，DO直接拿來當DTO用何嘗不可? 但是需要做些資料處裡的情境，像是把value1, value2, value3這種遠古髒資料轉乘valueList我就支持寫一個map struct來專門處理。

## 在階層上偷吃步
我覺得用破窗效應來形容太嚴重了，如果偷吃步的代碼更少、更有效率、也很好維護，這偷吃步的代碼算是爛代碼嗎? 至於其他爛貨開發有樣學樣因此開發出難以維護的代碼，關我屁事，少道德綁架! 只要之後維護的開發有適度重購的概念與功力 + PM有講清需求的能力，代碼還是可以在某個需求開發階段把階層重新分好 + 把DTO跟DO分開。

公司有爛貨開發是我的錯? 這種咖原代碼維護能Clean，開發新代碼就能Clean?

## 難以執行的測試
* 嚴格來講萬物溝通都是透過Function
* 測試是用不同Data來驗證業務邏輯正確
* 要思考測試是測一個Function還是測一個Scenario，一個Scenario就是多個Function組成的結果

我支持把Datasource Data的存取Function Interface化，因為方便測試各種定義好的Mock Data，降低被資料元的狀態綁架風險。但是我不支持把Domain的Function Interface化，因為本來就是要測試他裡面的邏輯正確性，回傳一個Mock Result幹嘛?