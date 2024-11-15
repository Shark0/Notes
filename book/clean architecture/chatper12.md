# 強化架構中的邊界

## 邊界與依賴關係
用六角來舉例，雖然我不認為一定要強制做Adapter跟Input / Output Port，但是範例圖的確很好說明由外到內依賴關係。

## 存取修飾子
一個Send Money Use Case用到九個Class我個人覺得超假掰，除了相關SendMoneyService、DO、Repository必要外，其他東西不存在就真的很難維護嗎? 另外Springboot在JpaRepository已用package-private。

## 編譯後適應函數
雖然我不支持全六角實作，但是我支持由內而外的邏輯一致性。這章用ArchUnit寫一個Test當作範例舉例我個人覺得很新鮮。

## 建製成品
範例圖最左邊的三層架構我覺得很順眼，我的標準就是不要循環依賴就好，跟已存在的Use Case做串接時在產生Adapter工具就好。
