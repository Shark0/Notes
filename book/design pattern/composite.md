# Composite 設計模式的介紹

Composite 設計模式（組合模式）是一種結構型設計模式，它允許您將物件階層中的單一物件（葉節點）與物件群組（組合節點）視為同一類型的物件。這透過樹狀結構來統一處理個別物件與複合物件，讓客戶端無需區分它們是單一還是組合。這種模式特別適合用於建構部分-整體階層，例如檔案系統（檔案與資料夾）、UI 元件樹或圖形場景。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Composite 模式的核心動機是簡化客戶端對階層結構的遞迴操作，避免在程式碼中檢查「這是單一物件還是組合」。例如，在檔案系統中，您可以對資料夾呼叫 `display()` 方法，它會遞迴顯示所有子檔案，而無需客戶端分別處理檔案與資料夾。這促進了透明性和統一介面，符合「透明性」原則。

主要優點包括：
- **統一介面**：客戶端使用相同方法處理葉節點與組合節點。
- **易於擴展**：新增節點類型只需實作共同介面。
- **遞迴操作**：自然支援樹狀結構的遍歷與操作。

## 結構

Composite 模式涉及四個主要組件：

| 組件            | 描述                                                       |
|---------------|----------------------------------------------------------|
| **Component** | 抽象組件介面，定義共同方法（如 `display()`、`add(Child)`），葉節點與組合節點皆實作。   |
| **Leaf**      | 葉節點，實作 Component，但無子節點（例如單一檔案）。                          |
| **Composite** | 組合節點，實作 Component，維護子節點清單，並遞迴轉發操作（如 `add()`、`remove()`）。 |
| **Client**    | 客戶端，透過 Component 介面建構與操作樹狀結構。                            |

互動流程：
1. 客戶端建立 Leaf 或 Composite。
2. Composite 透過 `add()` 新增子節點（可為 Leaf 或另一 Composite）。
3. 呼叫 Component 的方法，組合節點遞迴處理子節點。
4. 葉節點直接執行操作。

## Java 範例

以下是簡單的檔案系統範例（FileComponent 作為 Component），檔案（FileLeaf）與資料夾（DirectoryComposite）可組合，形成樹狀結構：

```java
import java.util.*;

// Component 介面
interface FileComponent {
    void display();  // 顯示細節
    void add(FileComponent component);  // 新增子節點（葉節點忽略）
    void remove(FileComponent component);  // 移除子節點（葉節點忽略）
}

// Leaf（單一檔案）
class FileLeaf implements FileComponent {
    private String name;

    public FileLeaf(String name) {
        this.name = name;
    }

    @Override
    public void display() {
        System.out.println("File: " + name);
    }

    @Override
    public void add(FileComponent component) {
        // 葉節點無子節點
        throw new UnsupportedOperationException("Files can't have children");
    }

    @Override
    public void remove(FileComponent component) {
        // 葉節點無子節點
        throw new UnsupportedOperationException("Files can't have children");
    }
}

// Composite（資料夾）
class DirectoryComposite implements FileComponent {
    private String name;
    private List<FileComponent> children = new ArrayList<>();

    public DirectoryComposite(String name) {
        this.name = name;
    }

    @Override
    public void display() {
        System.out.println("Directory: " + name);
        for (FileComponent child : children) {
            child.display();  // 遞迴顯示
        }
    }

    @Override
    public void add(FileComponent component) {
        children.add(component);
    }

    @Override
    public void remove(FileComponent component) {
        children.remove(component);
    }
}

// 使用範例
public class CompositeDemo {
    public static void main(String[] args) {
        // 建立葉節點
        FileComponent file1 = new FileLeaf("document.txt");
        FileComponent file2 = new FileLeaf("image.jpg");

        // 建立組合節點
        DirectoryComposite docs = new DirectoryComposite("Documents");
        docs.add(file1);
        docs.add(file2);

        DirectoryComposite home = new DirectoryComposite("Home");
        home.add(docs);
        home.add(new FileLeaf("readme.txt"));

        // 顯示整個結構
        home.display();
        // 輸出:
        // Directory: Home
        // Directory: Documents
        // File: document.txt
        // File: image.jpg
        // File: readme.txt
    }
}
```

此範例展示如何建構樹狀結構，並透過 `display()` 遞迴顯示所有節點。

## 優點與缺點

| 優點                    | 缺點                                 |
|-----------------------|------------------------------------|
| 統一處理單一與複合物件，簡化客戶端程式碼。 | 可能違反 LSP（葉節點的 `add()` 拋出例外，需小心設計）。 |
| 支援動態建構與修改樹狀結構。        | 組合節點可能過度通用，難以強制子節點類型。              |
| 易於實現遞迴演算法（如遍歷）。       | 除錯樹狀結構較複雜。                         |

## 何時使用

- 當需要表示部分-整體階層，且客戶端需忽略組合邏輯時。
- 適用於檔案系統、UI 元件樹（Swing 的 Container/Component）、圖形場景或 XML DOM 處理。
- 避免在階層淺薄或需嚴格類型檢查的情境中使用，以防過度抽象。