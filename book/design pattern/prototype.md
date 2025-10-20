# Prototype 設計模式的介紹

Prototype 設計模式（原型模式）是一種創建型設計模式，它允許您透過複製（clone）現有物件來建立新物件，而非從零建構。這有助於避免建立複雜物件的昂貴成本，特別適合物件結構深層或初始化耗時的情境。透過原型，您可以輕鬆產生物件的變體，符合「原型」概念，如細胞分裂產生相同副本。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。Java 語言內建支援此模式，透過 `Cloneable` 介面與 `Object.clone()` 方法。

## 目的與動機

使用 Prototype 模式的核心動機是優化物件建立過程，當新物件與現有物件相似時，直接複製可節省時間與資源。例如，在遊戲開發中，產生多個敵人物件時，您可以從一個原型複製屬性（如位置、血量），而無需每次重新設定。這避免了建構函式中的重複邏輯，並支援深層複製（deep clone）來處理巢狀物件。

主要優點包括：
- **效能優化**：複製比從頭建構更快。
- **靈活性**：易於產生物件變體。
- **減少子類別**：無需為每個變體建立新類別。

## 結構

Prototype 模式涉及四個主要組件：

| 組件                    | 描述                                             |
|-----------------------|------------------------------------------------|
| **Prototype**         | 抽象原型介面，定義 `clone()` 方法來複製自身（通常繼承 `Cloneable`）。 |
| **ConcretePrototype** | 具體原型，實作 Prototype，提供 `clone()` 邏輯（淺層或深層複製）。    |
| **Client**            | 客戶端，使用 `clone()` 產生新物件，並可修改複製體而不影響原型。          |
| **Factory**           | （選用）原型管理器，儲存多個原型並依類型返回複製體。                     |

互動流程：
1. 客戶端建立 ConcretePrototype。
2. 呼叫 `clone()` 產生新物件。
3. 修改複製體的狀態（外在狀態），原型保持不變。

## Java 範例

以下是簡單的形狀原型範例（Shape 作為 Prototype），支援圓形（Circle）的複製，並示範深層複製（使用序列化）：

```java
import java.io.*;

// Prototype 介面（繼承 Cloneable）
abstract class Shape implements Cloneable {
    protected String type;
    protected int x, y;

    public Shape() {}

    public Shape(String type, int x, int y) {
        this.type = type;
        this.x = x;
        this.y = y;
    }

    public void setX(int x) { this.x = x; }
    public void setY(int y) { this.y = y; }
    public String getType() { return type; }
    public int getX() { return x; }
    public int getY() { return y; }

    // 淺層 clone
    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

    // 深層 clone（使用序列化）
    public Object deepClone() throws IOException, ClassNotFoundException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream oos = new ObjectOutputStream(bos);
        oos.writeObject(this);

        ByteArrayInputStream bis = new ByteArrayInputStream(bos.toByteArray());
        ObjectInputStream ois = new ObjectInputStream(bis);
        return ois.readObject();
    }

    public abstract void draw();
}

// ConcretePrototype
class Circle extends Shape {
    private int radius;

    public Circle(int x, int y, int radius) {
        super("Circle", x, y);
        this.radius = radius;
    }

    public int getRadius() { return radius; }
    public void setRadius(int radius) { this.radius = radius; }

    @Override
    public void draw() {
        System.out.println("Drawing Circle [type: " + type + ", x: " + x + ", y: " + y + ", radius: " + radius + "]");
    }

    // 自訂 clone（淺層）
    @Override
    public Object clone() throws CloneNotSupportedException {
        Circle cloned = (Circle) super.clone();
        return cloned;
    }
}

// 使用範例
public class PrototypeDemo {
    public static void main(String[] args) throws CloneNotSupportedException, IOException, ClassNotFoundException {
        // 建立原型
        Circle original = new Circle(10, 20, 5);
        original.draw();
        // 輸出: Drawing Circle [type: Circle, x: 10, y: 20, radius: 5]

        // 淺層 clone
        Circle shallowClone = (Circle) original.clone();
        shallowClone.setRadius(10);  // 修改複製體
        original.draw();  // 原型不變
        // 輸出: Drawing Circle [type: Circle, x: 10, y: 20, radius: 5]
        shallowClone.draw();
        // 輸出: Drawing Circle [type: Circle, x: 10, y: 20, radius: 10]

        // 深層 clone（假設 Shape 實作 Serializable）
        Circle deepClone = (Circle) original.deepClone();
        deepClone.setRadius(15);
        original.draw();  // 原型不變
        // 輸出: Drawing Circle [type: Circle, x: 10, y: 20, radius: 5]
        deepClone.draw();
        // 輸出: Drawing Circle [type: Circle, x: 10, y: 20, radius: 15]
    }
}
```

此範例展示淺層（`clone()`）與深層（序列化）複製。注意：深層複製需實作 `Serializable` 介面（在 Shape 中添加 `implements Serializable`）。

## 優點與缺點

| 優點             | 缺點                                                     |
|----------------|--------------------------------------------------------|
| 快速產生相似物件，優化效能。 | 複製邏輯複雜，尤其是深層複製（需處理循環引用）。                               |
| 減少建構函式依賴，易於測試。 | Java 的 `clone()` 易出錯（CloneNotSupportedException），建議自訂。 |
| 支援物件工廠模式。      | 不適合物件狀態頻繁變更的情境。                                        |

## 何時使用

- 當物件建立成本高，或需大量產生相似物件時。
- 適用於遊戲物件複製、文件模板或配置管理。
- 避免在物件簡單或不需複製時使用；優先考慮建構函式或工廠模式。
