# Decorator 設計模式的介紹

Decorator 設計模式（裝飾器模式）是一種結構型設計模式，它允許您在不修改原有物件的情況下，動態地為物件附加新的行為。這透過建立一個包裝器（Decorator）物件，來「裝飾」原始物件，讓您可以逐步堆疊功能，而不需建立多個子類別。這種模式特別適合用於擴展功能，而不違反開放/封閉原則。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Decorator 模式的核心動機是避免類別爆炸（class explosion），當原有類別需要多種組合功能時。傳統繼承會產生大量子類別（如 CoffeeWithMilk、CoffeeWithSugar），而 Decorator 讓您透過物件組合動態添加功能。例如，在咖啡店系統中，您可以從基本咖啡開始，然後添加牛奶、糖等裝飾器，每個裝飾器只負責單一責任，輕鬆組合出不同口味。

主要優點包括：
- **動態擴展**：在執行時添加或移除功能。
- **單一責任**：每個裝飾器只處理一個額外行為。
- **透明性**：裝飾後的物件與原始物件有相同介面。

## 結構

Decorator 模式涉及四個主要組件：

| 組件                    | 描述                                             |
|-----------------------|------------------------------------------------|
| **Component**         | 抽象組件介面，定義核心方法（例如 `getDescription()`、`cost()`）。 |
| **ConcreteComponent** | 具體組件，實作 Component，提供基本功能（例如基本咖啡）。              |
| **Decorator**         | 抽象裝飾器，實作 Component，持有 Component 引用，並轉發呼叫。      |
| **ConcreteDecorator** | 具體裝飾器，擴展 Decorator，添加新行為並呼叫被裝飾物件的方法。           |

互動流程：
1. 客戶端建立 ConcreteComponent。
2. 包裝 ConcreteDecorator（可多層）。
3. 呼叫頂層裝飾器的介面方法。
4. 裝飾器執行額外邏輯，然後遞迴轉發到內層組件。

## Java 範例

以下是咖啡店範例（Beverage 作為 Component），基本咖啡可添加牛奶（MilkDecorator）和糖（SugarDecorator）：

```java
// Component 介面
interface Beverage {
    String getDescription();
    double cost();
}

// ConcreteComponent
class BasicCoffee implements Beverage {
    @Override
    public String getDescription() {
        return "Basic Coffee";
    }

    @Override
    public double cost() {
        return 5.0;
    }
}

// Decorator 抽象類別
abstract class BeverageDecorator implements Beverage {
    protected Beverage beverage;

    public BeverageDecorator(Beverage beverage) {
        this.beverage = beverage;
    }

    @Override
    public String getDescription() {
        return beverage.getDescription();
    }

    @Override
    public double cost() {
        return beverage.cost();
    }
}

// ConcreteDecorator（牛奶）
class MilkDecorator extends BeverageDecorator {
    public MilkDecorator(Beverage beverage) {
        super(beverage);
    }

    @Override
    public String getDescription() {
        return beverage.getDescription() + " with Milk";
    }

    @Override
    public double cost() {
        return beverage.cost() + 1.0;
    }
}

// ConcreteDecorator（糖）
class SugarDecorator extends BeverageDecorator {
    public SugarDecorator(Beverage beverage) {
        super(beverage);
    }

    @Override
    public String getDescription() {
        return beverage.getDescription() + " with Sugar";
    }

    @Override
    public double cost() {
        return beverage.cost() + 0.5;
    }
}

// 使用範例
public class DecoratorDemo {
    public static void main(String[] args) {
        Beverage basicCoffee = new BasicCoffee();

        // 添加牛奶
        Beverage milkCoffee = new MilkDecorator(basicCoffee);
        System.out.println(milkCoffee.getDescription() + " costs $" + milkCoffee.cost());
        // 輸出: Basic Coffee with Milk costs $6.0

        // 添加牛奶和糖
        Beverage milkSugarCoffee = new SugarDecorator(new MilkDecorator(basicCoffee));
        System.out.println(milkSugarCoffee.getDescription() + " costs $" + milkSugarCoffee.cost());
        // 輸出: Basic Coffee with Milk with Sugar costs $6.5
    }
}
```

此範例展示如何動態組合裝飾器，計算描述與成本。

## 優點與缺點

| 優點                 | 缺點                    |
|--------------------|-----------------------|
| 支援無限組合功能，而不需大量子類別。 | 多層裝飾可能導致除錯困難（呼叫堆疊複雜）。 |
| 符合開放/封閉原則，易於擴展。    | 裝飾器介面需與組件一致，否則客戶端需調整。 |
| 物件組合優於繼承。          | 效能略低（額外物件與轉發）。        |

## 何時使用

- 當需要動態添加功能，且繼承不適合時。
- 適用於 IO 流（Java 的 BufferedReader 就是 Decorator 範例）、GUI 元件或文本格式化。
- 避免在功能組合少或效能關鍵的情境中使用，以防過度抽象。
