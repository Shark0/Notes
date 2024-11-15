# 測試架構

## 測試金字塔
看到System Tests、Integration Tests、Unit Test，個人經驗感覺上面要求都是Integration Tests居多。個人覺得要測就測Domain業務邏輯，測Web跟Data Source有種球員兼裁判的感覺。但要測試之前，也要把各Input會出現的測試結果先列好，可以參考LeetCode的測試方式。

## 領域實體的單元測試
案例測試驗證了Withdraw後金額 + Actitiy紀錄數量，個人喜歡這種測試方式，但是這本書不寫註解很容易惹怒人欸，強調維護的書寫出案例時不寫註解? 另外他也要寫沒有餘額時withdraw失敗的案例，成功跟失敗的案例都要才周全麻!

## 使用案例的單元測試
感覺沒有很單元欸，還是有依賴withdraw跟deposit這幾個function。

## 網頁層轉接器的整合測試
個人覺得為了得到Http Status 200的測試沒意義

## 儲存層轉接器的整合測試
個人覺得測試假資料能不能取成功跟存成功的沒意義

## 系統主要路徑的系統測試
個人認為測試假API的沒意義，要測測真的。

## 要多少測試才算夠
個人是覺得Domain層重要業務邏輯當然是100%，其他Web跟Datasource我個人認為沒意義。