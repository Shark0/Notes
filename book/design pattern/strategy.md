# Strategy 設計模式的介紹

Strategy 設計模式（策略模式）是一種行為型設計模式，它定義了一系列演算法，讓它們可以互換，並將每個演算法封裝成獨立的類別，讓演算法可以獨立於使用它的客戶端而變化。這種模式特別適合用於讓物件在執行時動態選擇行為，例如排序演算法（快速排序、合併排序）或付款方式（信用卡、PayPal），避免在 Context 中使用大量 if-else 條件判斷。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Strategy 模式的核心動機是將演算法與使用它的物件分離，讓演算法可以獨立變化，而不影響客戶端程式碼。這有助於符合開放/封閉原則（OCP），易於擴展新策略。例如，在電商系統中，訂單處理可根據使用者選擇的付款方式切換策略，而無需修改訂單類別本身。這促進了程式碼的重用與維護性。

主要優點包括：
- **互換性**：演算法可動態替換。
- **單一責任**：每個策略類別只負責一個演算法。
- **易測試**：獨立測試每個策略。

## 結構

Strategy 模式涉及四個主要組件：

| 組件                   | 描述                                                    |
|----------------------|-------------------------------------------------------|
| **Strategy**         | 抽象策略介面，定義共同的演算法方法（例如 `pay(amount)`）。                  |
| **ConcreteStrategy** | 具體策略，實作 Strategy，提供特定演算法邏輯（例如 CreditCardStrategy）。    |
| **Context**          | 上下文類別，持有 Strategy 引用，並委託行為給策略（例如 `processPayment()`）。 |
| **Client**           | 客戶端，建立 Context 並設定具體策略。                               |

互動流程：
1. 客戶端建立 ConcreteStrategy 並設定到 Context。
2. 客戶端呼叫 Context 的方法。
3. Context 轉發到當前 Strategy 執行。

## Java 範例

以下是簡單的付款處理範例（PaymentStrategy 作為 Strategy），支援信用卡和 PayPal 策略：

```java
// Strategy 介面
interface PaymentStrategy {
    void pay(double amount);
}

// ConcreteStrategy 1: 信用卡
class CreditCardStrategy implements PaymentStrategy {
    private String cardNumber;

    public CreditCardStrategy(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    @Override
    public void pay(double amount) {
        System.out.println("Paid $" + amount + " using Credit Card: " + cardNumber);
    }
}

// ConcreteStrategy 2: PayPal
class PayPalStrategy implements PaymentStrategy {
    private String email;

    public PayPalStrategy(String email) {
        this.email = email;
    }

    @Override
    public void pay(double amount) {
        System.out.println("Paid $" + amount + " using PayPal: " + email);
    }
}

// Context
class ShoppingCart {
    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void processPayment(double amount) {
        paymentStrategy.pay(amount);  // 委託給策略
    }
}

// 使用範例
public class StrategyDemo {
    public static void main(String[] args) {
        ShoppingCart cart = new ShoppingCart();

        // 使用信用卡
        cart.setPaymentStrategy(new CreditCardStrategy("1234-5678-9012-3456"));
        cart.processPayment(100.0);  // 輸出: Paid $100.0 using Credit Card: 1234-5678-9012-3456

        // 切換到 PayPal
        cart.setPaymentStrategy(new PayPalStrategy("user@example.com"));
        cart.processPayment(50.0);   // 輸出: Paid $50.0 using PayPal: user@example.com
    }
}
```

此範例展示如何動態切換策略，處理不同付款方式。輸出顯示各策略的執行結果。

## 優點與缺點

| 優點              | 缺點                 |
|-----------------|--------------------|
| 演算法可互換，易擴展新策略。  | 客戶端需了解所有策略，增加認知負荷。 |
| 消除條件式判斷，符合 OCP。 | 若策略多，可能導致類別數量增加。   |
| 促進程式碼重用與測試。     | 策略物件需額外建立，略增記憶體使用。 |

## 何時使用

- 當多個類別有相同行為但實現不同，或需在執行時切換演算法時。
- 適用於排序工具（Collections.sort() 內部使用）、壓縮演算法或驗證規則。
- 避免在演算法固定或少於 2 種的情境中使用；改用簡單多型或 if-else。

