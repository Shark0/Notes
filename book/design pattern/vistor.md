### Visitor 設計模式的介紹

Visitor 設計模式是一種行為型設計模式，它允許您在不修改物件類別的情況下，為一組物件新增新的操作。它將演算法（操作）與物件結構分離，使得在物件結構可能隨時間變化的情況下，執行操作變得更容易。這種模式特別適用於當您有一組穩定的類別，但需要對它們執行多種變化的操作時。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

### 目的與動機

使用 Visitor 模式的的核心動機是避免在物件類別中加入不相關的操作。例如，假設有一個幾何形狀的類別階層（Circle、Rectangle 等）。如果直接在每個形狀類別中新增如「計算面積」或「渲染為 SVG」等操作，將違反單一責任原則。相反，Visitor 模式讓您在獨立的 Visitor 類別中定義這些操作，保持形狀類別專注於其領域邏輯。

主要優點包括：
- **演算法封裝**：操作可以獨立於物件結構演進。
- **單一責任**：元素類別不需要知道所有可能的操作。
- **開放/封閉原則**：可以新增新的 Visitor（操作）而不需修改現有元素類別。

### 結構

Visitor 模式涉及五個主要組件：

| 組件              | 描述                                                                 |
|-------------------|----------------------------------------------------------------------|
| **Visitor**      | 抽象基類或介面，宣告每個具體元素類型的 `visit()` 方法（例如 `visitCircle()`、`visitRectangle()`）。 |
| **ConcreteVisitor** | 實作 Visitor 介面，提供每個 `visit()` 方法的實際邏輯。每個具體 Visitor 代表特定操作（例如 AreaCalculatorVisitor、RendererVisitor）。 |
| **Element**      | 抽象基類或介面，用於被訪問的物件，包含 `accept(Visitor)` 方法來接收 Visitor。 |
| **ConcreteElement** | 實作 Element 介面。每個類別有自己的 `accept()`，呼叫 Visitor 的對應 `visit(this)` 方法，並傳入自身。 |
| **ObjectStructure** | （選用）維護元素集合的類別，提供遍歷元素並套用 Visitor 的方法（例如形狀清單）。 |

互動流程：
1. 客戶端建立 ConcreteVisitor。
2. ObjectStructure（或直接 Element）呼叫 `accept(visitor)`。
3. 在 `accept()` 內，元素轉發到 Visitor 的對應 `visit(this)` 方法。
4. Visitor 對元素執行操作，並可回傳結果。

這種雙重派遣機制（先依元素類型，後依 Visitor 類型）實現類型特定行為。

### Java 範例

以下是使用形狀階層的簡單 Java 實作：

```java
import java.util.*;

// Visitor 介面
interface ShapeVisitor {
    void visitCircle(Circle circle);
    void visitRectangle(Rectangle rectangle);
}

// 具體 Visitor
class AreaCalculator implements ShapeVisitor {
    private double area = 0.0;

    @Override
    public void visitCircle(Circle circle) {
        area += Math.PI * circle.getRadius() * circle.getRadius();
    }

    @Override
    public void visitRectangle(Rectangle rectangle) {
        area += rectangle.getWidth() * rectangle.getHeight();
    }

    public double getArea() {
        return area;
    }
}

class Renderer implements ShapeVisitor {
    private List<String> output = new ArrayList<>();

    @Override
    public void visitCircle(Circle circle) {
        output.add("Rendering circle with radius " + circle.getRadius());
    }

    @Override
    public void visitRectangle(Rectangle rectangle) {
        output.add("Rendering rectangle " + rectangle.getWidth() + "x" + rectangle.getHeight());
    }

    public List<String> getOutput() {
        return output;
    }
}

// Element 介面
interface Shape {
    void accept(ShapeVisitor visitor);
}

// 具體 Element
class Circle implements Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    public double getRadius() {
        return radius;
    }

    @Override
    public void accept(ShapeVisitor visitor) {
        visitor.visitCircle(this);
    }
}

class Rectangle implements Shape {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    public double getWidth() {
        return width;
    }

    public double getHeight() {
        return height;
    }

    @Override
    public void accept(ShapeVisitor visitor) {
        visitor.visitRectangle(this);
    }
}

// Object Structure
class ShapeCollection {
    private List<Shape> shapes = new ArrayList<>();

    public void add(Shape shape) {
        shapes.add(shape);
    }

    public void applyVisitor(ShapeVisitor visitor) {
        for (Shape shape : shapes) {
            shape.accept(visitor);
        }
    }
}

// 使用範例
public class VisitorDemo {
    public static void main(String[] args) {
        ShapeCollection collection = new ShapeCollection();
        collection.add(new Circle(5));
        collection.add(new Rectangle(4, 6));

        // 計算面積
        AreaCalculator areaVisitor = new AreaCalculator();
        collection.applyVisitor(areaVisitor);
        System.out.println("Total area: " + areaVisitor.getArea());  // 輸出: Total area: 78.53981633974483

        // 渲染形狀
        Renderer renderVisitor = new Renderer();
        collection.applyVisitor(renderVisitor);
        System.out.println(renderVisitor.getOutput());  // 輸出: [Rendering circle with radius 5.0, Rendering rectangle 4.0x6.0]
    }
}
```

此範例展示如何使用相同結構支援多種操作（面積計算與渲染）透過不同的 Visitor。

### 優點與缺點

| 優點                             | 缺點                                                                    |
|----------------------------------|-------------------------------------------------------------------------|
| 在不修改元素類別的情況下新增新操作。 | 如果新增元素類型，必須更新所有 Visitor（違反開放/封閉原則於 Visitor）。 |
| 將相關操作集中於單一 Visitor 類別。 | 如果操作眾多，可能導致大量 Visitor 實作。                              |
| 適合遍歷複雜結構（例如編譯器的 AST）。 | 增加間接性，雙重派遣可能使程式碼難以追蹤。                              |

### 何時使用

- 當類別階層（元素）穩定但操作（Visitor）會變化時。
- 適用於編譯器（訪問抽象語法樹）、UI 框架（遍歷小部件樹）或會計系統（對交易物件套用報告）等情境。
- 避免在元素階層不穩定或操作緊密耦合於元素時使用。

如需更深入探討，推薦 Refactoring.Guru 等資源，提供互動 UML 圖與多語言程式碼。