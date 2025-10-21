# State 設計模式的介紹

State 設計模式（狀態模式）是一種行為型設計模式，它允許物件在其內部狀態改變時改變其行為，看起來就像改變了類別本身。這種模式透過將狀態封裝成獨立的類別，讓 Context（上下文）委託給當前 State 物件處理行為。這特別適合處理複雜的狀態轉換，例如遊戲中的角色狀態（idle、running、jumping）或訂單流程（pending、shipped、delivered）。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 State 模式的核心動機是消除 Context 中過多的條件式判斷（if-else），將每個狀態的行為分離到獨立類別中。這有助於避免狀態轉換的邏輯散亂，並使新增狀態變得簡單。例如，在 TCP 連接中，狀態如 Closed、Listen、SynSent 可獨立定義行為，Context 只需切換 State 物件。

主要優點包括：
- **消除條件式**：每個狀態獨立，易維護。
- **開放/封閉原則**：新增狀態只需新增 State 類別。
- **單一責任**：每個 State 只處理一種狀態行為。

## 結構

State 模式涉及四個主要組件：

| 組件                | 描述                                                |
|-------------------|---------------------------------------------------|
| **Context**       | 上下文類別，持有當前 State 引用，並委託行為給 State（例如 `request()`）。 |
| **State**         | 抽象狀態介面，定義行為方法（例如 `handle()`），並可定義狀態轉換。            |
| **ConcreteState** | 具體狀態，實作 State，提供特定行為，並可轉換到其他 State。               |
| **Client**        | 客戶端，建立 Context 並觸發行為。                             |

互動流程：
1. Context 持有初始 ConcreteState。
2. 客戶端呼叫 Context 方法。
3. Context 轉發到當前 State。
4. State 執行行為，並若需則轉換 Context 的 State。

## Java 範例

以下是簡單的 TCP 連接範例（TCPConnection 作為 Context），支援 Closed 和 Open 狀態的行為：

```java
// State 介面
interface TCPState {
    void open(TCPConnection connection);
    void close(TCPConnection connection);
    void acknowledge(TCPConnection connection);
}

// ConcreteState 1: Closed
class ClosedState implements TCPState {
    @Override
    public void open(TCPConnection connection) {
        System.out.println("Opening connection...");
        connection.setState(new OpenState());
    }

    @Override
    public void close(TCPConnection connection) {
        System.out.println("Already closed.");
    }

    @Override
    public void acknowledge(TCPConnection connection) {
        System.out.println("Cannot acknowledge while closed.");
    }
}

// ConcreteState 2: Open
class OpenState implements TCPState {
    @Override
    public void open(TCPConnection connection) {
        System.out.println("Already open.");
    }

    @Override
    public void close(TCPConnection connection) {
        System.out.println("Closing connection...");
        connection.setState(new ClosedState());
    }

    @Override
    public void acknowledge(TCPConnection connection) {
        System.out.println("Acknowledging...");
    }
}

// Context
class TCPConnection {
    private TCPState state = new ClosedState();  // 初始狀態

    public void setState(TCPState state) {
        this.state = state;
    }

    public void open() {
        state.open(this);
    }

    public void close() {
        state.close(this);
    }

    public void acknowledge() {
        state.acknowledge(this);
    }
}

// 使用範例
public class StateDemo {
    public static void main(String[] args) {
        TCPConnection connection = new TCPConnection();

        // 初始 Closed
        connection.open();     // 輸出: Opening connection...
        connection.acknowledge();  // 輸出: Acknowledging...

        // 轉換到 Open
        connection.close();    // 輸出: Closing connection...
        connection.open();     // 輸出: Already open.
        connection.acknowledge();  // 輸出: Cannot acknowledge while closed.
    }
}
```

此範例展示狀態轉換如何改變行為。輸出顯示不同狀態下的方法回應。

## 優點與缺點

| 優點                     | 缺點                     |
|------------------------|------------------------|
| 消除 Context 的條件式，易擴展狀態。 | 若狀態多，可能導致類別數量增加（類別爆炸）。 |
| 每個狀態獨立，符合 SRP。         | 狀態轉換邏輯需小心管理，避免無限迴圈。    |
| 行為與狀態分離，易測試。           | 初始設計較複雜。               |

## 何時使用

- 當物件行為依內部狀態變化，且狀態轉換複雜時。
- 適用於有限狀態機（FSM）、遊戲 AI 狀態或工作流程引擎。
- 避免在狀態少或轉換簡單的情境中使用；改用策略模式或簡單 switch。
