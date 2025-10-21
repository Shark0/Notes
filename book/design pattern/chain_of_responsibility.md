# Chain of Responsibility 設計模式的介紹

Chain of Responsibility 設計模式（責任鏈模式）是一種行為型設計模式，它允許您將發送者與接收者解耦，讓多個物件有機會處理請求。請求沿著鏈條傳遞，直到某個處理器能處理它，或鏈條結束。這種模式特別適合用於事件處理、驗證流程或日誌記錄，讓每個處理器只負責特定責任，而無需知道後續處理器。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Chain of Responsibility 模式的核心動機是避免硬編碼請求與處理器的關聯，讓處理邏輯動態鏈接。這有助於擴展系統，而無需修改發送者。例如，在日誌系統中，您可以有不同級別的處理器（Debug、Info、Error），請求依級別傳遞，直到匹配的處理器處理它。這促進了鬆散耦合與單一責任原則。

主要優點包括：
- **解耦發送與接收**：發送者無需知道誰處理請求。
- **易擴展**：新增處理器只需加入鏈條。
- **靈活性**：可動態調整鏈條順序。

## 結構

Chain of Responsibility 模式涉及四個主要組件：

| 組件                  | 描述                                           |
|---------------------|----------------------------------------------|
| **Handler**         | 抽象處理器介面，定義 `handleRequest()` 方法，並持有下一個處理器引用。 |
| **ConcreteHandler** | 具體處理器，實作 Handler，檢查是否能處理請求，若能則處理，否則轉發給下一個。   |
| **Client**          | 客戶端，建立鏈條並發送請求。                               |
| **Request**         | 請求物件，包含資料供處理器使用。                             |

互動流程：
1. 客戶端建立 ConcreteHandler 鏈條（每個設定下一個）。
2. 發送請求到鏈條頭部。
3. 每個 Handler 檢查條件，若匹配則處理並停止；否則轉發。

## Java 範例

以下是簡單的日誌處理範例（Logger 作為 Handler），支援不同級別（Debug、Info、Error），請求依級別傳遞：

```java
// Request 類別
class LogMessage {
    private int level;  // 0: DEBUG, 1: INFO, 2: ERROR
    private String message;

    public LogMessage(int level, String message) {
        this.level = level;
        this.message = message;
    }

    public int getLevel() { return level; }
    public String getMessage() { return message; }
}

// Handler 抽象類別
abstract class Logger {
    protected Logger nextLogger;  // 下一個處理器
    protected int level;

    public void setNextLogger(Logger nextLogger) {
        this.nextLogger = nextLogger;
    }

    public void logMessage(LogMessage message) {
        if (message.getLevel() >= this.level) {
            write(message);  // 處理
        }
        if (nextLogger != null) {
            nextLogger.logMessage(message);  // 轉發
        }
    }

    protected abstract void write(LogMessage message);
}

// ConcreteHandler 1: Error Logger
class ErrorLogger extends Logger {
    public ErrorLogger(int level) {
        this.level = level;
    }

    @Override
    protected void write(LogMessage message) {
        System.out.println("Error Logger: " + message.getMessage());
    }
}

// ConcreteHandler 2: Info Logger
class InfoLogger extends Logger {
    public InfoLogger(int level) {
        this.level = level;
    }

    @Override
    protected void write(LogMessage message) {
        System.out.println("Info Logger: " + message.getMessage());
    }
}

// ConcreteHandler 3: Debug Logger
class DebugLogger extends Logger {
    public DebugLogger(int level) {
        this.level = level;
    }

    @Override
    protected void write(LogMessage message) {
        System.out.println("Debug Logger: " + message.getMessage());
    }
}

// 使用範例
public class ChainOfResponsibilityDemo {
    public static void main(String[] args) {
        // 建立鏈條: Debug -> Info -> Error
        Logger debugLogger = new DebugLogger(0);
        Logger infoLogger = new InfoLogger(1);
        Logger errorLogger = new ErrorLogger(2);

        debugLogger.setNextLogger(infoLogger);
        infoLogger.setNextLogger(errorLogger);

        // 測試不同級別請求
        debugLogger.logMessage(new LogMessage(0, "Debug message"));  // 輸出: Debug Logger: Debug message \n Info Logger: Debug message \n Error Logger: Debug message
        System.out.println("---");

        debugLogger.logMessage(new LogMessage(1, "Info message"));   // 輸出: Info Logger: Info message \n Error Logger: Info message
        System.out.println("---");

        debugLogger.logMessage(new LogMessage(2, "Error message"));  // 輸出: Error Logger: Error message
    }
}
```

此範例展示請求如何沿鏈條傳遞，低級別請求會被多個處理器處理，高級別僅由匹配者處理。輸出顯示不同級別的行為。

## 優點與缺點

| 優點               | 缺點                 |
|------------------|--------------------|
| 解耦請求發送與處理，易動態鏈接。 | 請求可能無人處理（需預設終止邏輯）。 |
| 符合單一責任，每處理器專注一事。 | 鏈條過長可能影響效能（遞迴呼叫）。  |
| 易於新增/移除處理器。      | 除錯時難追蹤請求路徑。        |

## 何時使用

- 當多個物件可能處理同一請求，且順序不定時。
- 適用於事件處理器（GUI 事件）、驗證鏈（表單驗證）或中間件（HTTP 請求處理）。
- 避免在請求總是單一處理者或順序固定時使用；改用簡單 if-else。
