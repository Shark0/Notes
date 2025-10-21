# Singleton 設計模式的介紹

Singleton 設計模式（單例模式）是一種創建型設計模式，它確保一個類別只有一個實例，並提供一個全球存取點來存取該實例。這種模式特別適合用於管理共享資源，例如資料庫連接、快取管理器或日誌記錄器，避免多個實例導致資源浪費或不一致狀態。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Singleton 模式的核心動機是限制物件的實例化數量為一，確保系統中只有一個控制點。這有助於在多執行緒環境中安全地管理全域狀態，而不需外部協調。例如，在應用程式中，只需一個配置管理器來讀取設定檔，若有多個實例，可能導致設定不一致或重複載入。

主要優點包括：
- **全球存取**：提供單一入口點，簡化客戶端使用。
- **資源控制**：避免多實例導致的資源耗損。
- **懶加載**：僅在首次存取時建立實例。

## 結構

Singleton 模式涉及三個主要組件：

| 組件                | 描述                                              |
|-------------------|-------------------------------------------------|
| **Singleton**     | 單例類別，包含私有建構子、靜態實例變數及 `getInstance()` 方法來返回唯一實例。 |
| **Client**        | 客戶端，透過 `getInstance()` 取得單例並使用其方法。              |
| **Thread Safety** | （選用）在多執行緒環境中，使用同步機制（如雙重檢查鎖定）確保安全。               |

互動流程：
1. 客戶端呼叫 `getInstance()`。
2. 若實例為 null，則建立唯一實例（使用同步保護）。
3. 返回實例，後續呼叫直接返回相同實例。

## Java 範例

以下是執行緒安全的 Singleton 範例，使用雙重檢查鎖定（Double-Checked Locking）來優化效能：

```java
// Singleton 類別（執行緒安全版本）
public class Singleton {
    // 私有靜態實例（volatile 確保可見性）
    private static volatile Singleton instance;

    // 私有建構子，防止外部實例化
    private Singleton() {
        // 可在這裡初始化資源
        System.out.println("Singleton instance created");
    }

    // 靜態工廠方法
    public static Singleton getInstance() {
        if (instance == null) {  // 第一次檢查（無鎖）
            synchronized (Singleton.class) {  // 同步塊
                if (instance == null) {  // 第二次檢查（有鎖）
                    instance = new Singleton();
                }
            }
        }
        return instance;
    }

    // 示例方法
    public void showMessage() {
        System.out.println("Hello from Singleton: " + this.hashCode());
    }
}

// 使用範例
public class SingletonDemo {
    public static void main(String[] args) {
        // 多執行緒測試（模擬）
        for (int i = 0; i < 5; i++) {
            Singleton singleton = Singleton.getInstance();
            singleton.showMessage();  // 輸出: Singleton instance created (僅一次)，後續為相同 hashCode
        }
        // 驗證唯一性
        Singleton s1 = Singleton.getInstance();
        Singleton s2 = Singleton.getInstance();
        System.out.println("s1 == s2: " + (s1 == s2));  // 輸出: true
    }
}
```

此範例在首次呼叫 `getInstance()` 時建立實例，並確保多執行緒環境下的安全性。輸出顯示實例僅建立一次，且所有引用指向相同物件。

### 優點與缺點

| 優點             | 缺點                     |
|----------------|------------------------|
| 確保單一實例，控制資源存取。 | 違反單一責任原則（類別兼顧建立與業務邏輯）。 |
| 懶加載與執行緒安全易實現。  | 難以單元測試（無法注入模擬實例）。      |
| 全球存取簡化程式碼。     | 若濫用，可能成為全域變數，增加耦合。     |

## 何時使用

- 當需要嚴格控制實例數量為一，且有全球存取需求時。
- 適用於日誌記錄器、連接池管理、配置管理或快取系統。
- 避免在物件不需唯一或需依賴注入的情境中使用；現代替代如 Spring 的 `@Singleton` 或依賴注入框架。
