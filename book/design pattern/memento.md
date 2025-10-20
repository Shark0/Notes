# Memento 設計模式的介紹

Memento 設計模式（備忘錄模式）是一種行為型設計模式，它允許您在不破壞封裝的情況下，擷取並外部化一個物件的內部狀態，以便之後可以將物件恢復到先前的狀態。這種模式特別適合實現「復原」（undo）或「重做」（redo）功能，讓系統能夠保存和還原物件的狀態，而不暴露其內部細節。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Memento 模式的的核心動機是提供一種安全的「快照」機制，讓物件可以保存其狀態並在需要時恢復，而不需將內部狀態公開給外部類別。這有助於實現版本控制或錯誤恢復功能。例如，在文字編輯器中，您可以保存文件狀態，然後在使用者按下「復原」時恢復之前的版本，而不需讓編輯器類別暴露其私有變數。

主要優點包括：
- **保護封裝**：內部狀態僅在 Memento 中暴露給 Originator。
- **簡化狀態管理**：Caretaker 不需了解狀態細節，只負責儲存 Memento。
- **支援多層復原**：可以堆疊多個 Memento 來實現歷史記錄。

## 結構

Memento 模式涉及三個主要組件：

| 組件             | 描述                                                                                    |
|----------------|---------------------------------------------------------------------------------------|
| **Originator** | 擁有內部狀態的物件，提供 `createMemento()` 方法來產生 Memento，以及 `restore(Memento)` 方法來從 Memento 恢復狀態。 |
| **Memento**    | 儲存 Originator 狀態的物件。通常分為「窄介面」（僅用於儲存/恢復，Caretaker 無法存取）和「寬介面」（Originator 可存取狀態細節）。     |
| **Caretaker**  | 負責儲存和管理的 Memento，但無法查看或修改其內容。常使用堆疊來管理多個狀態（例如 undo 歷史）。                                |

互動流程：
1. Originator 呼叫 `createMemento()` 產生一個 Memento，捕捉當前狀態。
2. Caretaker 接收並儲存 Memento（例如推入堆疊）。
3. 當需要恢復時，Caretaker 將 Memento 傳回給 Originator 的 `restore(Memento)` 方法。
4. Originator 從 Memento 讀取狀態並恢復自身。

## Java 範例

以下是使用簡單文字編輯器（Editor）作為 Originator 的範例，展示如何保存和恢復文字內容：

```java
import java.util.*;

// Memento 類別（寬介面給 Originator，窄介面給 Caretaker）
class EditorMemento {
    private final String content;  // 僅 Originator 可存取

    public EditorMemento(String content) {
        this.content = content;
    }

    public String getContent() {  // 僅供 Originator 使用
        return content;
    }
}

// Originator
class Editor {
    private String content = "";

    public void setContent(String content) {
        this.content = content;
    }

    public EditorMemento createMemento() {
        return new EditorMemento(content);  // 捕捉當前狀態
    }

    public void restore(EditorMemento memento) {
        this.content = memento.getContent();  // 從 Memento 恢復
    }

    public String getContent() {
        return content;
    }
}

// Caretaker
class History {
    private List<EditorMemento> mementos = new ArrayList<>();

    public void push(EditorMemento memento) {
        mementos.add(memento);
    }

    public EditorMemento pop() {
        int size = mementos.size();
        if (size == 0) {
            return null;
        }
        EditorMemento last = mementos.get(size - 1);
        mementos.remove(size - 1);
        return last;
    }
}

// 使用範例
public class MementoDemo {
    public static void main(String[] args) {
        Editor editor = new Editor();
        History history = new History();

        // 初始內容
        editor.setContent("Hello, World!");
        System.out.println("Current: " + editor.getContent());

        // 保存狀態
        history.push(editor.createMemento());

        // 修改內容
        editor.setContent("Hello, Java!");
        System.out.println("Modified: " + editor.getContent());

        // 恢復狀態
        EditorMemento memento = history.pop();
        if (memento != null) {
            editor.restore(memento);
            System.out.println("Restored: " + editor.getContent());  // 輸出: Restored: Hello, World!
        }
    }
}
```

此範例展示如何使用 History（Caretaker）管理 Memento 堆疊，實現單次復原。輸出為：
```
Current: Hello, World!
Modified: Hello, Java!
Restored: Hello, World!
```

## 優點與缺點

| 優點                               | 缺點                                |
|----------------------------------|-----------------------------------|
| 維持封裝性，狀態僅限於 Memento 內部。          | 如果狀態很大（例如複雜物件），Memento 可能消耗大量記憶體。 |
| 易於實現多層復原（使用堆疊或清單）。               | Caretaker 無法選擇特定狀態（需額外邏輯如索引）。     |
| 與其他模式結合良好（例如 Command 模式用於 undo）。 | 在語言無私有成員支援時，難以完全隱藏狀態。             |

## 何時使用

- 當需要支援復原/重做功能，且不希望暴露物件內部狀態時。
- 適用於文字編輯器、遊戲存檔、資料庫交易回滾或圖形編輯軟體等情境。
- 避免在狀態極大或頻繁變化的系統中使用，以防記憶體問題。
