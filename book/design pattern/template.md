# Template Method 設計模式的介紹

Template Method 設計模式（模板方法模式）是一種行為型設計模式，它定義了一個演算法的骨架，將某些步驟延遲到子類別中實作。這種模式讓子類別可以重新定義演算法的某些特定步驟，而不改變演算法的結構。它特別適合用於定義固定流程但允許自訂的部分，例如文件處理流程（讀取、處理、寫入），其中處理步驟可由子類別變更。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Template Method 模式的核心動機是避免在每個子類別中重複定義演算法骨架，將不變的步驟集中在父類別中。這有助於程式碼重用，並符合霍利伍德原則（「不要呼叫我們，我們會呼叫你」）。例如，在報告生成系統中，父類別定義「生成報告」的模板（開頭、中間、結尾），子類別只需實作特定部分（如資料格式化），避免重複程式碼。

主要優點包括：
- **程式碼重用**：父類別定義通用骨架。
- **控制流程**：確保演算法步驟順序不變。
- **易擴展**：子類別只需覆寫特定方法。

## 結構

Template Method 模式涉及三個主要組件：

| 組件                | 描述                                                                |
|-------------------|-------------------------------------------------------------------|
| **AbstractClass** | 抽象類別，定義模板方法（演算法骨架，如 `generateReport()`），並包含抽象的鉤子方法（hook methods）。 |
| **ConcreteClass** | 具體類別，繼承 AbstractClass，實作抽象方法，提供特定邏輯。                              |
| **Client**        | 客戶端，產生 ConcreteClass 並呼叫模板方法。                                     |

互動流程：
1. 客戶端呼叫 AbstractClass 的模板方法。
2. 模板方法依序呼叫抽象/鉤子方法。
3. 子類別實作的具體方法被執行。

## Java 範例
以下是簡單的報告生成範例（ReportGenerator 作為 AbstractClass），支援文字報告（TextReport）和 HTML 報告（HtmlReport）的格式化：

```java
// AbstractClass
abstract class ReportGenerator {
    // 模板方法：定義演算法骨架
    public final void generateReport() {
        System.out.println("Starting report generation...");
        prepareHeader();      // 步驟 1: 準備標頭
        formatData();         // 步驟 2: 格式化資料（抽象方法，由子類實作）
        prepareFooter();      // 步驟 3: 準備頁尾
        System.out.println("Report generation completed.");
    }

    // 鉤子方法（可選，由子類覆寫）
    protected void prepareHeader() {
        System.out.println("Default header prepared.");
    }

    // 抽象方法（必須由子類實作）
    protected abstract void formatData();

    protected void prepareFooter() {
        System.out.println("Default footer prepared.");
    }
}

// ConcreteClass 1: 文字報告
class TextReport extends ReportGenerator {
    @Override
    protected void formatData() {
        System.out.println("Formatting data as plain text.");
    }

    @Override
    protected void prepareHeader() {
        System.out.println("Text report header: 'Sales Report'");
    }
}

// ConcreteClass 2: HTML 報告
class HtmlReport extends ReportGenerator {
    @Override
    protected void formatData() {
        System.out.println("Formatting data as HTML table.");
    }

    @Override
    protected void prepareFooter() {
        System.out.println("HTML report footer: <hr> End of Report </body>");
    }
}

// 使用範例
public class TemplateMethodDemo {
    public static void main(String[] args) {
        ReportGenerator textReport = new TextReport();
        textReport.generateReport();
        // 輸出:
        // Starting report generation...
        // Text report header: 'Sales Report'
        // Formatting data as plain text.
        // Default footer prepared.
        // Report generation completed.

        System.out.println("---");

        ReportGenerator htmlReport = new HtmlReport();
        htmlReport.generateReport();
        // 輸出:
        // Starting report generation...
        // Default header prepared.
        // Formatting data as HTML table.
        // HTML report footer: <hr> End of Report </body>
        // Report generation completed.
    }
}
```

此範例展示模板方法 `generateReport()` 如何強制步驟順序，子類別只自訂特定部分。輸出顯示不同報告類型的變更。

## 優點與缺點
| 優點              | 缺點                      |
|-----------------|-------------------------|
| 強制演算法結構，重用通用邏輯。 | 子類別可能需覆寫多個方法，增加複雜度。     |
| 易擴展新變體，符合 OCP。  | 父類別的模板方法為 final，難以修改骨架。 |
| 簡化客戶端使用。        | 若鉤子方法未使用，子類別需空實作。       |

## 何時使用
- 當演算法有固定步驟但部分可變時。
- 適用於框架設計（JDBC 的模板類別）、文件生成或遊戲流程。
- 避免在所有步驟皆可變或演算法簡單的情境中使用；改用組合或策略模式。
