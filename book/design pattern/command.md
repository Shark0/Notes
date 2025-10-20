# Command 設計模式的介紹

Command
設計模式（命令模式）是一種行為型設計模式，它將一個請求封裝為一個物件，從而讓您可以將請求參數化、排入佇列、記錄日誌或支援可復原操作。這種模式特別適合用於實現「復原」（undo）功能、菜單系統或遠端控制，讓發送者（Invoker）與接收者（Receiver）解耦，透過命令物件中間調度。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Command
模式的的核心動機是將操作轉換為物件，讓系統可以動態處理請求，而不需直接呼叫接收者的方法。這有助於實現靈活的控制流程，例如在圖形編輯器中，將「繪製線條」封裝為命令物件，支援復原或重做操作，而無需讓控制器知道每個操作的細節。

主要優點包括：

- **解耦發送者與接收者**：Invoker 只需執行命令，無需知道具體實現。
- **支援復原與重做**：命令可儲存狀態，輕鬆實現 undo/redo。
- **擴展性**：易於新增新命令，而不修改現有類別。

## 結構

Command 模式涉及五個主要組件：

| 組件                  | 描述                                                     |
|---------------------|--------------------------------------------------------|
| **Command**         | 抽象命令介面，定義 `execute()` 方法（有時包含 `undo()`）。               |
| **ConcreteCommand** | 具體命令，實作 Command，綁定 Receiver 的動作，並在 `execute()` 中呼叫其方法。 |
| **Receiver**        | 接收者，擁有實際執行邏輯的物件（例如燈光類別的開/關方法）。                         |
| **Invoker**         | 調用者，持有命令物件並呼叫 `execute()`，負責管理命令（如堆疊用於 undo）。          |
| **Client**          | 客戶端，建立 ConcreteCommand 並設定其 Receiver，然後傳給 Invoker。     |

互動流程：

1. 客戶端建立 ConcreteCommand，設定 Receiver。
2. Invoker 接收命令並呼叫 `execute()`。
3. ConcreteCommand 轉發到 Receiver 的具體方法。
4. 對於 undo，Invoker 可呼叫 `undo()` 從堆疊彈出並復原。

## Java 範例

以下是簡單的遙控器範例（RemoteControl 作為 Invoker），控制燈光（Light 作為 Receiver），支援開燈（OnCommand）和關燈（OffCommand），並包含
undo 功能：

```java
import java.util.*;

// Command 介面
interface Command {
    void execute();

    void undo();
}

// Receiver
class Light {
    private String location;

    public Light(String location) {
        this.location = location;
    }

    public void on() {
        System.out.println(location + " light is on");
    }

    public void off() {
        System.out.println(location + " light is off");
    }
}

// 具體 Command（開燈）
class LightOnCommand implements Command {
    private Light light;

    public LightOnCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.on();
    }

    @Override
    public void undo() {
        light.off();  // 復原為關燈
    }
}

// 具體 Command（關燈）
class LightOffCommand implements Command {
    private Light light;

    public LightOffCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.off();
    }

    @Override
    public void undo() {
        light.on();  // 復原為開燈
    }
}

// Invoker
class RemoteControl {
    private Command command;
    private Stack<Command> history = new Stack<>();  // 用於 undo

    public void setCommand(Command command) {
        this.command = command;
    }

    public void pressButton() {
        command.execute();
        history.push(command);  // 記錄命令
    }

    public void pressUndo() {
        if (!history.isEmpty()) {
            Command lastCommand = history.pop();
            lastCommand.undo();
        } else {
            System.out.println("No commands to undo");
        }
    }
}

// 使用範例
public class CommandDemo {
    public static void main(String[] args) {
        Light livingRoomLight = new Light("Living Room");

        Command lightOn = new LightOnCommand(livingRoomLight);
        Command lightOff = new LightOffCommand(livingRoomLight);

        RemoteControl remote = new RemoteControl();

        // 開燈
        remote.setCommand(lightOn);
        remote.pressButton();  // 輸出: Living Room light is on

        // 關燈
        remote.setCommand(lightOff);
        remote.pressButton();  // 輸出: Living Room light is off

        // 復原（最後一個命令是關燈，所以復原為開燈）
        remote.pressUndo();  // 輸出: Living Room light is on

        // 再復原（最後一個命令是開燈，所以復原為關燈）
        remote.pressUndo();  // 輸出: Living Room light is off
    }
}
```

此範例展示如何透過遙控器執行命令並支援 undo。輸出顯示燈光狀態的變化與復原。

## 優點與缺點

| 優點                    | 缺點                               |
|-----------------------|----------------------------------|
| 解耦操作發送與執行，便於擴展。       | 如果命令類別過多，可能導致類別爆炸。               |
| 易於實現 undo/redo 和日誌記錄。 | 需要額外儲存狀態，對於複雜物件可能消耗記憶體。          |
| 符合開放/封閉原則。            | 初始設定較繁瑣（每個操作需一 ConcreteCommand）。 |

## 何時使用
- 當需要將請求參數化、排隊或支援復原操作時。
- 適用於 GUI 菜單系統、交易系統（命令作為事務）、遊戲輸入處理或宏命令（組合多個命令）。
- 避免在簡單操作或不需 undo 的情境中使用，以防過度設計。
