# Factory Method 設計模式的介紹

Factory Method 設計模式（工廠方法模式）是一種創建型設計模式，它定義了一個建立物件的介面，讓子類別決定實例化哪個類別。這種模式延遲物件的實例化到子類別，讓程式碼更靈活，並符合開放/封閉原則。特別適合在框架或應用程式中，當產品類型依上下文變化時使用，例如建立不同類型的文件處理器。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Factory Method 模式的核心動機是將物件建立邏輯委託給子類別，避免父類別硬編碼具體產品類型。這有助於擴展系統，而無需修改現有程式碼。例如，在一個文件應用中，父類別 `Application` 可定義 `createDocument()` 方法，讓 `WordApplication` 子類別產生 Word 文件，`ExcelApplication` 產生 Excel 文件，實現多型化建立。

主要優點包括：
- **子類決定產品**：延遲綁定，易於新增新產品。
- **符合 OCP**：新增子類別而不修改父類別。
- **程式碼重用**：父類別提供通用框架。

## 結構

Factory Method 模式涉及四個主要組件：

| 組件                  | 描述                                               |
|---------------------|--------------------------------------------------|
| **Product**         | 抽象產品介面，定義產品的行為（例如 `open()`、`save()`）。            |
| **ConcreteProduct** | 具體產品，實作 Product，提供實際邏輯（例如 WordDocument）。         |
| **Creator**         | 抽象創建者，定義 `factoryMethod()` 來建立產品，並使用產品的通用方法。     |
| **ConcreteCreator** | 具體創建者，實作 `factoryMethod()`，返回對應 ConcreteProduct。 |

互動流程：
1. 客戶端建立 ConcreteCreator。
2. ConcreteCreator 的通用方法呼叫 `factoryMethod()` 建立產品。
3. 使用產品執行操作。

## Java 範例

以下是簡單的文件應用範例（Application 作為 Creator），支援 Word 和 Excel 文件的建立：

```java
// Product 介面
interface Document {
    void open();
    void save();
}

// ConcreteProduct 1
class WordDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Word document");
    }

    @Override
    public void save() {
        System.out.println("Saving Word document");
    }
}

// ConcreteProduct 2
class ExcelDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Excel document");
    }

    @Override
    public void save() {
        System.out.println("Saving Excel document");
    }
}

// Creator（抽象）
abstract class Application {
    // 工廠方法
    public abstract Document factoryMethod();

    // 通用方法，使用產品
    public void newDocument() {
        Document doc = factoryMethod();
        doc.open();
        doc.save();
    }
}

// ConcreteCreator 1
class WordApplication extends Application {
    @Override
    public Document factoryMethod() {
        return new WordDocument();
    }
}

// ConcreteCreator 2
class ExcelApplication extends Application {
    @Override
    public Document factoryMethod() {
        return new ExcelDocument();
    }
}

// 使用範例
public class FactoryMethodDemo {
    public static void main(String[] args) {
        Application wordApp = new WordApplication();
        wordApp.newDocument();  // 輸出: Opening Word document \n Saving Word document

        Application excelApp = new ExcelApplication();
        excelApp.newDocument();  // 輸出: Opening Excel document \n Saving Excel document
    }
}
```

此範例展示如何透過不同應用子類別建立對應文件，通用方法 `newDocument()` 自動使用正確產品。

## 優點與缺點

| 優點               | 缺點                                 |
|------------------|------------------------------------|
| 延遲產品決定，易於擴展新類型。  | 子類別數量可能增加（每個產品需一 ConcreteCreator）。 |
| 符合開放/封閉原則，程式碼穩定。 | 若產品階層深，可能導致類別爆炸。                   |
| 促進多型化與框架設計。      | 比簡單建構函式稍複雜。                        |

## 何時使用

- 當物件建立邏輯需由子類決定，或系統需支援多種產品時。
- 適用於框架開發（例如 Spring 的 BeanFactory）、文件處理器或資料庫連接工廠。
- 避免在產品類型固定或簡單的情境中使用；改用靜態工廠方法。
