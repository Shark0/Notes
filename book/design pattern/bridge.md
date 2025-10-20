# Bridge 設計模式的介紹

Bridge 設計模式（橋接模式）是一種結構型設計模式，它將抽象部分與其實現部分分離，使兩者可以獨立變化。這透過建立兩個獨立的階層（抽象階層與實現階層）來實現，讓您可以組合不同的抽象與實現，而不需產生大量子類別。這種模式特別適合用於避免類別爆炸，例如在圖形系統中，形狀（圓形、正方形）與繪圖方式（2D、3D）可以獨立擴展。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Bridge 模式的核心動機是將抽象與實現解耦，允許它們獨立演進。傳統繼承會導致抽象與實現緊密耦合，產生如 `RedCircle`、`BlueCircle`、`RedSquare` 等交叉子類別，違反單一責任原則。Bridge 模式使用組合（而非繼承）來連結抽象與實現，讓您可以輕鬆新增形狀或顏色，而不修改現有類別。

主要優點包括：
- **解耦抽象與實現**：兩階層獨立變化。
- **擴展性**：易於新增新抽象或新實現。
- **符合開放/封閉原則**：無需修改既有類別。

## 結構

Bridge 模式涉及五個主要組件：

| 組件                      | 描述                                         |
|-------------------------|--------------------------------------------|
| **Abstraction**         | 抽象化，定義抽象介面，並持有 Implementor 引用。             |
| **RefinedAbstraction**  | 精煉抽象化，擴展 Abstraction，提供更高層次的操作（例如 Circle）。 |
| **Implementor**         | 實現化介面，定義實現相關的操作（例如 `drawCircle()`）。        |
| **ConcreteImplementor** | 具體實現化，實作 Implementor，提供具體邏輯（例如 RedCircle）。 |
| **Client**              | 客戶端，透過 Abstraction 建立物件並操作。                |

互動流程：
1. 客戶端建立 RefinedAbstraction，設定 ConcreteImplementor。
2. Abstraction 呼叫其方法，轉發到 Implementor 的實現。
3. Implementor 執行具體操作。

## Java 範例

以下是簡單的圖形繪圖範例（Shape 作為 Abstraction），支援圓形（Circle）與不同顏色實現（RedCircle、GreenCircle）：

```java
// Implementor 介面
interface DrawAPI {
    void drawCircle(int radius, int x, int y);
}

// ConcreteImplementor 1
class RedCircle implements DrawAPI {
    @Override
    public void drawCircle(int radius, int x, int y) {
        System.out.println("Drawing red circle [radius: " + radius + ", x: " + x + ", y: " + y + "]");
    }
}

// ConcreteImplementor 2
class GreenCircle implements DrawAPI {
    @Override
    public void drawCircle(int radius, int x, int y) {
        System.out.println("Drawing green circle [radius: " + radius + ", x: " + x + ", y: " + y + "]");
    }
}

// Abstraction
abstract class Shape {
    protected DrawAPI drawAPI;

    protected Shape(DrawAPI drawAPI) {
        this.drawAPI = drawAPI;
    }

    public abstract void draw();  // 抽象方法
}

// RefinedAbstraction
class Circle extends Shape {
    private int radius, x, y;

    public Circle(int radius, int x, int y, DrawAPI drawAPI) {
        super(drawAPI);
        this.radius = radius;
        this.x = x;
        this.y = y;
    }

    @Override
    public void draw() {
        drawAPI.drawCircle(radius, x, y);
    }
}

// 使用範例
public class BridgeDemo {
    public static void main(String[] args) {
        Shape redCircle = new Circle(10, 100, 100, new RedCircle());
        Shape greenCircle = new Circle(20, 200, 200, new GreenCircle());

        redCircle.draw();    // 輸出: Drawing red circle [radius: 10, x: 100, y: 100]
        greenCircle.draw();  // 輸出: Drawing green circle [radius: 20, x: 200, y: 200]
    }
}
```

此範例展示如何組合不同形狀與顏色實現，新增如 `BlueCircle` 或 `Square` 無需修改 Shape。

## 優點與缺點

| 優點              | 缺點                 |
|-----------------|--------------------|
| 解耦抽象與實現，易於獨立擴展。 | 增加設計複雜度（需管理兩個階層）。  |
| 避免類別爆炸，支援多維度變化。 | 執行時組合可能略增間接性與效能開銷。 |
| 符合單一責任與開放/封閉原則。 | 初始學習曲線較陡峭。         |

## 何時使用

- 當抽象與實現可能獨立變化，且避免繼承導致的類別爆炸時。
- 適用於驅動程式（JDBC 與不同資料庫）、GUI 工具箱（抽象視窗與不同 OS 實現）或多媒體系統（抽象播放器與不同格式解碼器）。
- 避免在抽象與實現緊密耦合或變化少的情境中使用，以防過度工程化。
