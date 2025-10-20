# Proxy 設計模式的介紹

Proxy 設計模式（代理模式）是一種結構型設計模式，它提供了一個代理物件（Proxy），用來控制對真實物件（RealSubject）的存取。這允許您在不修改真實物件的情況下，新增額外的功能，如延遲載入、存取控制或遠端代理。代理物件與真實物件實作相同的介面，讓客戶端無需區分兩者。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Proxy 模式的的核心動機是為真實物件提供一個中介層，管理其存取或行為，而不影響真實物件的實現。例如，在圖形應用中，載入大型影像可能耗時，您可以使用 Proxy 物件來延遲載入（lazy loading），只有在需要顯示時才真正載入影像。這有助於優化效能、保護資源或實現虛擬代理（如 RMI 遠端呼叫）。

主要優點包括：
- **控制存取**：代理可新增驗證、快取或日誌功能。
- **透明性**：客戶端視代理為真實物件，無需改變程式碼。
- **靈活性**：支援多種代理類型（如虛擬代理、保護代理）。

## 結構

Proxy 模式涉及四個主要組件：

| 組件              | 描述                                                   |
|-----------------|------------------------------------------------------|
| **Subject**     | 抽象主體介面，定義真實物件與代理物件的共同方法（例如 `display()`）。             |
| **RealSubject** | 真實主體，實作 Subject 介面，提供實際邏輯（例如影像載入與顯示）。                |
| **Proxy**       | 代理物件，實作 Subject 介面，持有 RealSubject 的引用，並在適當時機建立或轉發呼叫。 |
| **Client**      | 客戶端，透過 Subject 介面與代理或真實物件互動。                         |

互動流程：
1. 客戶端呼叫 Proxy 的方法。
2. Proxy 檢查條件（如是否已載入），若需則建立或初始化 RealSubject。
3. Proxy 轉發呼叫到 RealSubject，並可包裝額外邏輯（如快取結果）。

## Java 範例

以下是簡單的影像代理範例（ImageProxy 作為 Proxy），支援延遲載入影像，只有在顯示時才真正載入檔案：

```java
// Subject 介面
interface Image {
    void display();
}

// RealSubject
class RealImage implements Image {
    private String filename;

    public RealImage(String filename) {
        this.filename = filename;
        loadFromDisk();  // 模擬載入
    }

    private void loadFromDisk() {
        System.out.println("Loading " + filename + " from disk...");
    }

    @Override
    public void display() {
        System.out.println("Displaying " + filename);
    }
}

// Proxy
class ImageProxy implements Image {
    private RealImage realImage;
    private String filename;

    public ImageProxy(String filename) {
        this.filename = filename;
    }

    @Override
    public void display() {
        if (realImage == null) {
            realImage = new RealImage(filename);  // 延遲載入
        }
        realImage.display();
    }
}

// 使用範例
public class ProxyDemo {
    public static void main(String[] args) {
        Image image = new ImageProxy("test.jpg");

        // 第一次顯示：會載入
        System.out.println("First display:");
        image.display();
        // 輸出:
        // First display:
        // Loading test.jpg from disk...
        // Displaying test.jpg

        // 第二次顯示：已載入，直接顯示
        System.out.println("Second display:");
        image.display();
        // 輸出:
        // Second display:
        // Displaying test.jpg
    }
}
```

此範例展示 Proxy 如何延遲 RealImage 的建立，直到 `display()` 被呼叫。輸出顯示載入只發生一次。

## 優點與缺點

| 優點               | 缺點                         |
|------------------|----------------------------|
| 優化資源使用（如延遲載入）。   | 增加額外層級，可能引入效能開銷（雖然通常可控）。   |
| 易於新增控制邏輯而不改真實物件。 | 客戶端需了解介面一致性，否則可能混淆代理與真實物件。 |
| 支援遠端或虛擬存取。       | 如果代理邏輯複雜，可能違反單一責任原則。       |

## 何時使用

- 當需要控制對物件的存取、延遲初始化或遠端代理時。
- 適用於影像/檔案載入、資料庫連接池、RMI 遠端呼叫或存取控制（如權限檢查）。
- 避免在物件存取簡單且無效能需求的情境中使用，以防不必要的複雜度。
