# Iterator 設計模式的介紹

Iterator 設計模式（迭代器模式）是一種行為型設計模式，它提供了一種方法來依序存取聚合物件（Aggregate）的元素，而無需暴露其底層表示。這允許您在不了解集合內部結構的情況下，遍歷其元素。這種模式特別適合用於集合類別（如清單、樹或圖），讓不同類型的集合可以提供統一的遍歷介面。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。Java 標準庫中已內建支援此模式，透過 `Iterable` 和 `Iterator` 介面。

## 目的與動機

使用 Iterator 模式的的核心動機是將遍歷邏輯從集合類別中分離出來，避免在集合類別中硬編碼遍歷方法。這有助於支援多種遍歷方式（如前向、後向或篩選遍歷），並保持集合的封裝性。例如，在一個圖書館系統中，您可以對書籍清單進行迭代，而無需知道清單是陣列、鏈結清單還是資料庫查詢結果。

主要優點包括：
- **抽象化遍歷**：客戶端只需使用 Iterator 介面，無需關心集合實現。
- **多重遍歷**：支援同時多個迭代器遍歷同一集合。
- **單一責任**：集合負責儲存，迭代器負責遍歷。

## 結構

Iterator 模式涉及四個主要組件：

| 組件                    | 描述                                                     |
|-----------------------|--------------------------------------------------------|
| **Iterator**          | 抽象迭代器介面，定義遍歷方法（如 `hasNext()`、`next()`、`remove()`）。     |
| **ConcreteIterator**  | 具體迭代器，實作 Iterator 介面，追蹤位置並從 ConcreteAggregate 擷取元素。    |
| **Aggregate**         | 抽象聚合介面，定義 `createIterator()` 方法來產生 Iterator。           |
| **ConcreteAggregate** | 具體聚合，實作 Aggregate，維護元素集合並提供 `createIterator()` 來建立迭代器。 |

互動流程：
1. 客戶端從 ConcreteAggregate 呼叫 `createIterator()` 取得 Iterator。
2. 使用 `hasNext()` 檢查是否有下一個元素。
3. 使用 `next()` 擷取下一個元素，重複直到結束。

## Java 範例

以下是使用圖書館書籍清單（BookCollection 作為聚合）的簡單範例，展示如何使用自訂迭代器遍歷書籍：

```java
import java.util.*;

// Iterator 介面
interface BookIterator {
    boolean hasNext();
    Book next();
}

// 具體 Iterator
class BookIteratorImpl implements BookIterator {
    private List<Book> books;
    private int index = 0;

    public BookIteratorImpl(List<Book> books) {
        this.books = books;
    }

    @Override
    public boolean hasNext() {
        return index < books.size();
    }

    @Override
    public Book next() {
        if (hasNext()) {
            return books.get(index++);
        }
        return null;
    }
}

// Aggregate 介面
interface BookCollection {
    BookIterator createIterator();
}

// 具體 Aggregate
class BookCollectionImpl implements BookCollection {
    private List<Book> books = new ArrayList<>();

    public void addBook(Book book) {
        books.add(book);
    }

    @Override
    public BookIterator createIterator() {
        return new BookIteratorImpl(books);
    }

    public int getSize() {
        return books.size();
    }
}

// 簡單的 Book 類別
class Book {
    private String title;

    public Book(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }
}

// 使用範例
public class IteratorDemo {
    public static void main(String[] args) {
        BookCollection collection = new BookCollectionImpl();
        collection.addBook(new Book("Design Patterns"));
        collection.addBook(new Book("Clean Code"));
        collection.addBook(new Book("Effective Java"));

        BookIterator iterator = collection.createIterator();
        System.out.println("書籍清單：");
        while (iterator.hasNext()) {
            Book book = iterator.next();
            System.out.println(book.getTitle());
        }
        // 輸出:
        // 書籍清單：
        // Design Patterns
        // Clean Code
        // Effective Java
    }
}
```

此範例展示如何使用迭代器遍歷書籍清單。您也可以輕鬆擴展為支援多種迭代器（例如反向迭代器）。

## 優點與缺點

| 優點               | 缺點                                    |
|------------------|---------------------------------------|
| 支援多種遍歷演算法而不暴露結構。 | 在 Java 等語言中，已內建 Iterator，可能過度工程化自訂實作。 |
| 易於切換不同集合類型。      | 迭代器狀態管理可能增加複雜度（例如並行修改集合）。             |
| 符合單一責任原則。        | 不適合單次或簡單遍歷的簡單集合。                      |

## 何時使用

- 當需要為集合提供多種遍歷方式，或希望隱藏集合內部結構時。
- 適用於資料庫查詢結果、樹狀結構或任何聚合物件的遍歷。
- 在 Java 中，優先使用 `Iterable` 和 `Iterator` 來實作自訂集合；避免在簡單陣列中使用自訂迭代器。
