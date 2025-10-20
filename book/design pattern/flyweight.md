# Flyweight 設計模式的介紹

Flyweight 設計模式（享元模式）是一種結構型設計模式，它透過分享盡可能多的資料來最小化記憶體使用或計算成本。它將內在狀態（intrinsic state，共享的、不變的資料）與外在狀態（extrinsic state，執行時傳入的上下文特定資料）分離。這特別適合處理大量相似物件的系統，例如遊戲中的圖形元素或文字編輯器中的字元。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Flyweight 模式的核心動機是在有大量細粒度物件的情境中減少記憶體佔用。這些物件共享常見資料，但因上下文而異。例如，在森林模擬中，有數千棵樹，每棵樹可能共享「類型」（例如橡樹：高度、顏色），但位置（x, y）不同。若無 Flyweight，每棵樹都會重複儲存共享資料，浪費記憶體。模式使用工廠管理共享 Flyweight 物件的池，依內在狀態擷取它們，並結合外在狀態來完整行為。

主要優點包括：
- **記憶體效率**：共享不可變狀態避免重複。
- **執行時靈活性**：外在狀態動態提供。
- **可擴展性**：適合大量物件而不影響效能。

## 結構

Flyweight 模式涉及五個主要組件：

| 組件                            | 描述                                                     |
|-------------------------------|--------------------------------------------------------|
| **Flyweight**                 | 抽象享元介面，定義方法並接受外在狀態作為參數（例如 `display(x, y)`）。            |
| **ConcreteFlyweight**         | 具體享元，實作 Flyweight，儲存內在狀態（共享資料）並使用外在狀態執行操作。             |
| **FlyweightFactory**          | 享元工廠，管理具體享元的池（例如 HashMap），以內在狀態為鍵。若不存在則建立新物件，否則返回共享物件。 |
| **Client**                    | 客戶端，維護外在狀態並使用工廠取得享元，在操作時傳入外在資料。                        |
| **UnsharedConcreteFlyweight** | （選用）非共享享元，用於無法共享的物件。                                   |

互動流程：
1. 客戶端使用內在狀態向工廠請求享元。
2. 工廠檢查其池；若不存在，則建立並儲存新物件。
3. 客戶端呼叫享元方法，傳入外在狀態。
4. 享元結合內在與外在狀態執行操作。

## Java 範例

以下是使用森林與樹類型（內在：名稱、顏色；外在：x, y 位置）的簡單實作：

```java
import java.util.HashMap;
import java.util.Map;

// Flyweight 介面
interface TreeType {
    void display(int x, int y);  // 外在狀態：位置
}

// ConcreteFlyweight
class TreeTypeImpl implements TreeType {
    private final String name;   // 內在狀態
    private final String color;

    public TreeTypeImpl(String name, String color) {
        this.name = name;
        this.color = color;
    }

    @Override
    public void display(int x, int y) {
        System.out.println("Displaying " + name + " tree (color: " + color + ") at (" + x + ", " + y + ")");
    }
}

// FlyweightFactory
class TreeFactory {
    private static final Map<String, TreeType> treeTypes = new HashMap<>();

    public static TreeType getTreeType(String name, String color) {
        String key = name + "-" + color;
        TreeType type = treeTypes.get(key);
        if (type == null) {
            type = new TreeTypeImpl(name, color);
            treeTypes.put(key, type);
            System.out.println("Created new TreeType: " + key);
        }
        return type;
    }
}

// 使用範例
public class FlyweightDemo {
    public static void main(String[] args) {
        // 模擬種植 10 棵樹，共享類型
        for (int i = 0; i < 10; i++) {
            TreeType type = TreeFactory.getTreeType("Oak", "Green");  // 共享
            type.display(i * 10, i * 10);  // 外在：位置
        }
        // 輸出：僅建立一次 "Oak-Green"，然後重用於所有 10 次顯示
        // Created new TreeType: Oak-Green
        // Displaying Oak tree (color: Green) at (0, 0)
        // Displaying Oak tree (color: Green) at (10, 10)
        // ... (直到 90, 90)
    }
}
```

此範例顯示工廠僅為 "Oak-Green" 建立一個 `TreeTypeImpl`，並重用於所有樹木，節省記憶體。

## 優點與缺點

| 優點              | 缺點                      |
|-----------------|-------------------------|
| 大幅減少共享資料的記憶體使用。 | 需要小心分離內在/外在狀態，可能使設計複雜。  |
| 改善大量物件建立的效能。    | 執行時傳入外在狀態的成本；不適合頻繁狀態變更。 |
| 透過工廠集中管理共享物件。   | 增加間接性，共享實例可能使除錯更難。      |

## 何時使用
- 當處理大量相似物件且可共享狀態時（例如 UI 圖示、遊戲精靈、文件格式化）。
- 適合文字處理器（共享字體樣式）或模擬系統（粒子系統）。
- 避免物件很少共享狀態或外在狀態管理複雜時使用。

