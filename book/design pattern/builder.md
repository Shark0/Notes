# Builder 設計模式的介紹

Builder 設計模式（建構者模式）是一種創建型設計模式，它將一個複雜物件的建構過程與其表示分離，讓相同的建構步驟可以產生不同的表示。這有助於處理物件有許多可選屬性或參數的情境，避免使用巨型建構函式（telescoping constructor）。透過逐步建構，您可以產生不同變體的物件，而不需暴露內部細節。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。Java 中常用於如 `StringBuilder` 或 Lombok 的 `@Builder` 註解。

## 目的與動機

使用 Builder 模式的核心動機是簡化複雜物件的建立，當物件有許多選項時，傳統建構函式會產生多載入版本，導致程式碼冗長且易錯。Builder 模式提供流暢的 API，讓您逐步設定屬性，最後呼叫 `build()` 產生物件。例如，在建立一個訂單物件時，您可以選擇是否包含地址、付款方式等，而無需所有參數都為必填。

主要優點包括：
- **可讀性高**：鏈式呼叫（如 `builder.setName("A").setAge(30).build()`）使程式碼清晰。
- **不可變物件**：Product 可為不可變（immutable），提升安全性。
- **易擴展**：新增屬性只需更新 Builder，而不影響既有程式碼。

## 結構

Builder 模式涉及五個主要組件：

| 組件                  | 描述                                             |
|---------------------|------------------------------------------------|
| **Product**         | 複雜物件，包含最終屬性（例如 Order 類別）。                      |
| **Builder**         | 抽象建構者介面或類別，定義建構步驟方法（如 `setName()`）及 `build()`。 |
| **ConcreteBuilder** | 具體建構者，實作 Builder，逐步設定 Product 屬性並組裝物件。         |
| **Director**        | （選用）導演類別，協調建構步驟，確保特定順序（例如建構豪華車）。               |
| **Client**          | 客戶端，使用 Builder 逐步建構 Product。                   |

互動流程：
1. 客戶端建立 ConcreteBuilder。
2. 呼叫建構步驟方法設定屬性。
3. 呼叫 `build()` 取得 Product。
4. （若有）Director 指導 Builder 執行特定建構。

## Java 範例

以下是簡單的訂單建構範例（Order 作為 Product），支援逐步設定客戶名稱、產品清單及地址：

```java
import java.util.*;

// Product
class Order {
    private String customerName;
    private List<String> products = new ArrayList<>();
    private String address;

    // 私有建構子，強制使用 Builder
    private Order() {}

    // Getter 方法
    public String getCustomerName() { return customerName; }
    public List<String> getProducts() { return products; }
    public String getAddress() { return address; }

    @Override
    public String toString() {
        return "Order{customerName='" + customerName + "', products=" + products + ", address='" + address + "'}";
    }
}

// Builder 介面
interface OrderBuilder {
    OrderBuilder setCustomerName(String name);
    OrderBuilder setProducts(List<String> products);
    OrderBuilder setAddress(String address);
    Order build();
}

// ConcreteBuilder
class OrderBuilderImpl implements OrderBuilder {
    private Order order = new Order();

    @Override
    public OrderBuilder setCustomerName(String name) {
        order.customerName = name;
        return this;  // 鏈式呼叫
    }

    @Override
    public OrderBuilder setProducts(List<String> products) {
        order.products.addAll(products);
        return this;
    }

    @Override
    public OrderBuilder setAddress(String address) {
        order.address = address;
        return this;
    }

    @Override
    public Order build() {
        return order;
    }
}

// Director（可選，用於特定建構）
class OrderDirector {
    private OrderBuilder builder;

    public OrderDirector(OrderBuilder builder) {
        this.builder = builder;
    }

    public void constructFullOrder() {
        builder.setCustomerName("Default Customer")
               .setProducts(Arrays.asList("Laptop", "Mouse"))
               .setAddress("123 Main St");
    }
}

// 使用範例
public class BuilderDemo {
    public static void main(String[] args) {
        // 直接使用 Builder
        Order order1 = new OrderBuilderImpl()
                .setCustomerName("Alice")
                .setProducts(Arrays.asList("Book", "Pen"))
                .setAddress("456 Oak Ave")
                .build();
        System.out.println(order1);  // 輸出: Order{customerName='Alice', products=[Book, Pen], address='456 Oak Ave'}

        // 使用 Director
        OrderBuilder builder = new OrderBuilderImpl();
        OrderDirector director = new OrderDirector(builder);
        director.constructFullOrder();
        Order order2 = builder.build();
        System.out.println(order2);  // 輸出: Order{customerName='Default Customer', products=[Laptop, Mouse], address='123 Main St'}
    }
}
```

此範例展示鏈式呼叫的流暢 API，以及 Director 的協調作用。Product 的私有建構子確保必須透過 Builder 建立。

## 優點與缺點

| 優點               | 缺點                      |
|------------------|-------------------------|
| 支援複雜物件的逐步建構，易讀。  | 增加類別數量（需額外 Builder 類別）。 |
| 促進不可變物件設計，執行緒安全。 | 若屬性多，Builder 方法會變長。     |
| 易於擴展新屬性或變體。      | 比簡單建構函式略複雜。             |

## 何時使用

- 當物件建構邏輯複雜、有許多可選參數，或需不同表示時。
- 適用於 DTO（Data Transfer Object）建構、配置物件或如 `java.lang.StringBuilder` 的字串處理。
- 避免在物件簡單（少於 4 個參數）的情境中使用；改用建構函式或靜態工廠方法。
