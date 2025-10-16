### Mediator 設計模式的介紹

Mediator 設計模式（中介者模式）是一種行為型設計模式，它定義了一個中介者物件，讓一組物件之間的互動透過中介者進行，而不是直接互動。這有助於降低物件之間的耦合度，讓系統更容易維護和擴展。透過中介者，物件只需與中介者溝通，而無需了解其他物件的細節。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

### 目的與動機

使用 Mediator 模式的的核心動機是解決物件之間過度耦合的問題。例如，在一個聊天室系統中，如果每個使用者（User）直接向其他使用者發送訊息，會導致使用者類別充滿了對其他使用者的引用和邏輯，違反單一責任原則。Mediator 模式引入一個中介者（例如 ChatRoom），讓使用者只需向中介者發送訊息，中介者負責轉發給相關接收者。這促進了鬆散耦合，並集中了互動邏輯。

主要優點包括：
- **鬆散耦合**：物件間的直接依賴減少，中介者負責協調。
- **集中控制**：互動邏輯集中在中介者中，便於管理複雜行為。
- **易於擴展**：新增物件只需註冊到中介者，而不需修改現有類別。

### 結構

Mediator 模式涉及四個主要組件：

| 組件                    | 描述                                                  |
|-----------------------|-----------------------------------------------------|
| **Mediator**          | 抽象中介者介面，定義同事物件（Colleague）互動的方法（例如 `sendMessage()`）。 |
| **ConcreteMediator**  | 具體中介者，實作中介者介面，維護對所有同事物件的引用，並協調它們的互動。                |
| **Colleague**         | 抽象同事類別或介面，知道中介者，並透過中介者與其他同事溝通。                      |
| **ConcreteColleague** | 具體同事，實作 Colleague，僅透過中介者發送或接收訊息。                    |

互動流程：
1. 客戶端建立 ConcreteMediator 和多個 ConcreteColleague。
2. 每個 Colleague 註冊到 Mediator。
3. 當一個 Colleague 發送訊息時，它呼叫 Mediator 的方法。
4. Mediator 根據邏輯轉發訊息給其他相關 Colleague。

### Java 範例

以下是使用聊天室（ChatRoom 作為中介者）和使用者（User 作為同事）的簡單範例，展示如何透過中介者發送訊息：

```java
import java.util.*;

// Mediator 介面
interface ChatMediator {
    void sendMessage(String message, User user);
    void addUser(User user);
}

// 具體 Mediator
class ChatRoom implements ChatMediator {
    private List<User> users = new ArrayList<>();

    @Override
    public void sendMessage(String message, User user) {
        // 廣播訊息給所有其他使用者（除發送者）
        for (User u : users) {
            if (u != user) {
                u.receive(message);
            }
        }
    }

    @Override
    public void addUser(User user) {
        users.add(user);
    }
}

// Colleague 介面
abstract class User {
    protected ChatMediator mediator;
    protected String name;

    public User(ChatMediator mediator, String name) {
        this.mediator = mediator;
        this.name = name;
    }

    public abstract void send(String message);
    public abstract void receive(String message);
}

// 具體 Colleague
class ConcreteUser extends User {
    public ConcreteUser(ChatMediator mediator, String name) {
        super(mediator, name);
    }

    @Override
    public void send(String message) {
        System.out.println(this.name + " sends: " + message);
        mediator.sendMessage(message, this);
    }

    @Override
    public void receive(String message) {
        System.out.println(this.name + " receives: " + message);
    }
}

// 使用範例
public class MediatorDemo {
    public static void main(String[] args) {
        ChatMediator chatRoom = new ChatRoom();

        User user1 = new ConcreteUser(chatRoom, "Alice");
        User user2 = new ConcreteUser(chatRoom, "Bob");
        User user3 = new ConcreteUser(chatRoom, "Charlie");

        chatRoom.addUser(user1);
        chatRoom.addUser(user2);
        chatRoom.addUser(user3);

        user1.send("Hi, everyone!");
        // 輸出:
        // Alice sends: Hi, everyone!
        // Bob receives: Hi, everyone!
        // Charlie receives: Hi, everyone!

        user2.send("Hello, Alice!");
        // 輸出:
        // Bob sends: Hello, Alice!
        // Alice receives: Hello, Alice!
        // Charlie receives: Hello, Alice!
    }
}
```

此範例展示如何讓使用者透過聊天室發送訊息，中介者負責廣播給其他使用者。輸出顯示發送與接收的流程。

### 優點與缺點

| 優點              | 缺點                           |
|-----------------|------------------------------|
| 減少物件間直接耦合，便於重用。 | 中介者可能成為「大泥球」，集中太多邏輯導致單一責任違反。 |
| 集中互動邏輯，便於行為控制。  | 初始設計複雜，需要預先規劃互動規則。           |
| 易於新增同事物件。       | 如果互動模式簡單，可能過度工程化。            |

### 何時使用

- 當一組物件有複雜互動，且直接耦合會導致程式碼難以維護時。
- 適用於 GUI 應用（例如對話框元件透過中介者互動）、聊天系統、空中交通管制（飛機透過塔台溝通）或事件驅動系統。
- 避免在互動簡單或物件數量少時使用，以防不必要的複雜度。

如需更深入探討，推薦 Refactoring.Guru 等資源，提供互動 UML 圖與多語言程式碼。