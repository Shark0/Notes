# Abstract Factory 設計模式的介紹

Abstract Factory 設計模式（抽象工廠模式）是一種創建型設計模式，它提供了一個介面，用來建立一組相關或相依物件的家族，而無需指定它們的具體類別。這種模式特別適合用於建立一組互相關聯的物件，例如在 GUI 應用中，為不同作業系統（Windows、macOS）建立一致的 UI 元件家族（按鈕、文字方塊等），確保物件間的相容性。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Abstract Factory 模式的核心動機是統一管理相關物件的建立，避免客戶端直接實例化具體類別，這有助於支援多種「產品家族」（例如不同主題的 UI）。例如，在跨平台應用中，您可以根據使用者選擇的 OS 動態切換工廠，產生相應的元件，而無需修改客戶端程式碼。這促進了鬆散耦合與易擴展性。

主要優點包括：
- **物件家族一致性**：確保建立的物件互相關聯。
- **易於交換家族**：透過切換工廠實現多平台支援。
- **符合開放/封閉原則**：新增產品家族只需新增工廠。

## 結構

Abstract Factory 模式涉及五個主要組件：

| 組件                  | 描述                                                          |
|---------------------|-------------------------------------------------------------|
| **AbstractFactory** | 抽象工廠介面，定義建立抽象產品的方法（例如 `createButton()`、`createCheckbox()`）。 |
| **ConcreteFactory** | 具體工廠，實作 AbstractFactory，產生特定產品家族（例如 WindowsFactory）。        |
| **AbstractProduct** | 抽象產品介面，定義產品行為（例如 Button 的 `paint()`）。                       |
| **ConcreteProduct** | 具體產品，實作 AbstractProduct，提供實際邏輯（例如 WindowsButton）。           |
| **Client**          | 客戶端，透過 AbstractFactory 介面建立並使用產品。                           |

互動流程：
1. 客戶端建立 ConcreteFactory（依條件選擇）。
2. 呼叫工廠方法建立產品。
3. 使用產品執行操作。

## Java 範例

以下是簡單的 GUI 元件範例（GUIFactory 作為 AbstractFactory），支援 Windows 和 macOS 的按鈕與複選框：

```java
// AbstractProduct 1: Button
interface Button {
    void paint();
}

// ConcreteProduct 1.1: Windows Button
class WindowsButton implements Button {
    @Override
    public void paint() {
        System.out.println("Windows Button painted");
    }
}

// ConcreteProduct 1.2: Mac Button
class MacButton implements Button {
    @Override
    public void paint() {
        System.out.println("Mac Button painted");
    }
}

// AbstractProduct 2: Checkbox
interface Checkbox {
    void check();
}

// ConcreteProduct 2.1: Windows Checkbox
class WindowsCheckbox implements Checkbox {
    @Override
    public void check() {
        System.out.println("Windows Checkbox checked");
    }
}

// ConcreteProduct 2.2: Mac Checkbox
class MacCheckbox implements Checkbox {
    @Override
    public void check() {
        System.out.println("Mac Checkbox checked");
    }
}

// AbstractFactory
interface GUIFactory {
    Button createButton();
    Checkbox createCheckbox();
}

// ConcreteFactory 1: Windows Factory
class WindowsFactory implements GUIFactory {
    @Override
    public Button createButton() {
        return new WindowsButton();
    }

    @Override
    public Checkbox createCheckbox() {
        return new WindowsCheckbox();
    }
}

// ConcreteFactory 2: Mac Factory
class MacFactory implements GUIFactory {
    @Override
    public Button createButton() {
        return new MacButton();
    }

    @Override
    public Checkbox createCheckbox() {
        return new MacCheckbox();
    }
}

// Client 使用範例
public class AbstractFactoryDemo {
    public static void main(String[] args) {
        // 根據 OS 選擇工廠
        GUIFactory factory = new MacFactory();  // 或 new WindowsFactory();

        Button button = factory.createButton();
        Checkbox checkbox = factory.createCheckbox();

        button.paint();    // 輸出: Mac Button painted
        checkbox.check();  // 輸出: Mac Checkbox checked
    }
}
```

此範例展示如何透過工廠切換 UI 元件家族。新增如 LinuxFactory 只需實作 GUIFactory。

## 優點與缺點

| 優點               | 缺點                          |
|------------------|-----------------------------|
| 統一管理相關物件，建立一致家族。 | 新增產品類型需修改所有工廠（違反 OCP 於產品層）。 |
| 易於支援多平台或主題切換。    | 工廠介面可能過於龐大，若產品多。            |
| 隱藏具體類別，降低耦合。     | 比簡單建構函式複雜，學習曲線較高。           |

## 何時使用

- 當系統需建立一組互相關聯的物件，且家族可能變化時。
- 適用於跨平台 GUI 工具箱、資料庫驅動程式（不同 DBMS 的連接家族）或多主題應用。
- 避免在物件家族簡單或無需交換時使用；改用簡單工廠或建構者模式。
