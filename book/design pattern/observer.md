# Observer 設計模式的介紹

Observer 設計模式（觀察者模式）是一種行為型設計模式，它定義了物件之間的一對多依賴關係，當一個物件（Subject）的狀態改變時，所有依賴它的物件（Observer）會被通知並自動更新。這種模式特別適合用於事件驅動系統，例如 GUI 事件處理、股票價格變更通知或發布-訂閱系統，讓 Subject 與 Observer 鬆散耦合。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。Java 標準庫中已內建支援此模式，透過 `java.util.Observer` 和 `java.util.Observable`（但已過時），或更推薦使用 `PropertyChangeListener`。

## 目的與動機

使用 Observer 模式的核心動機是實現「不要呼叫我們，我們會呼叫你」（Hollywood Principle），讓 Subject 維持 Observer 清單，並在狀態變更時廣播通知。這避免了 Subject 直接依賴 Observer 的具體類別，促進動態註冊與移除。例如，在天氣監測系統中，當溫度改變時，顯示面板和警報器可自動更新，而無需 Subject 知道它們的細節。

主要優點包括：
- **鬆散耦合**：Subject 不知 Observer 細節，只需通知介面。
- **動態性**：可隨時新增/移除 Observer。
- **廣播通知**：支援一對多更新。

## 結構

Observer 模式涉及四個主要組件：

| 組件                   | 描述                                                   |
|----------------------|------------------------------------------------------|
| **Subject**          | 主體介面，定義註冊/移除 Observer 和通知方法（例如 `notifyObservers()`）。 |
| **ConcreteSubject**  | 具體主體，維護 Observer 清單，並在狀態變更時呼叫通知。                     |
| **Observer**         | 觀察者介面，定義 `update()` 方法來接收通知。                         |
| **ConcreteObserver** | 具體觀察者，實作 Observer，提供更新邏輯。                            |

互動流程：
1. ConcreteObserver 註冊到 ConcreteSubject。
2. Subject 狀態變更，呼叫 `notifyObservers()`。
3. 每個 Observer 的 `update()` 被呼叫，接收新狀態。

## Java 範例

以下是簡單的天氣監測範例（WeatherData 作為 ConcreteSubject），當溫度變更時通知顯示面板（DisplayObserver）：

```java
import java.util.*;

// Observer 介面
interface Observer {
    void update(float temperature);
}

// Subject 介面
interface Subject {
    void registerObserver(Observer observer);
    void removeObserver(Observer observer);
    void notifyObservers();
}

// ConcreteSubject
class WeatherData implements Subject {
    private List<Observer> observers = new ArrayList<>();
    private float temperature;

    @Override
    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    @Override
    public void removeObserver(Observer observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(temperature);
        }
    }

    public void setTemperature(float temperature) {
        this.temperature = temperature;
        notifyObservers();  // 狀態變更後通知
    }
}

// ConcreteObserver
class DisplayObserver implements Observer {
    private String name;

    public DisplayObserver(String name) {
        this.name = name;
    }

    @Override
    public void update(float temperature) {
        System.out.println(name + " received update: Temperature is " + temperature + "°C");
    }
}

// 使用範例
public class ObserverDemo {
    public static void main(String[] args) {
        WeatherData weatherData = new WeatherData();

        // 註冊觀察者
        Observer display1 = new DisplayObserver("Display Panel 1");
        Observer display2 = new DisplayObserver("Display Panel 2");
        weatherData.registerObserver(display1);
        weatherData.registerObserver(display2);

        // 模擬狀態變更
        weatherData.setTemperature(25.0f);  // 輸出: Display Panel 1 received update: Temperature is 25.0°C \n Display Panel 2 received update: Temperature is 25.0°C

        // 移除一個觀察者
        weatherData.removeObserver(display2);

        weatherData.setTemperature(30.0f);  // 輸出: Display Panel 1 received update: Temperature is 30.0°C
    }
}
```

此範例展示註冊、通知與移除的流程。輸出顯示狀態變更如何廣播給註冊的 Observer。

## 優點與缺點
| 優點                  | 缺點                           |
|---------------------|------------------------------|
| 鬆散耦合，易於新增 Observer。 | 通知順序不定，可能導致競爭條件（需額外同步）。      |
| 支援動態訂閱/取消，符合 OCP。   | 若 Observer 多，通知可能影響效能（廣播開銷）。 |
| 廣泛適用於事件系統。          | 除錯時難追蹤通知流程。                  |

## 何時使用
- 當一個物件的變更需通知多個依賴物件，且依賴動態變化時。
- 適用於 GUI 事件（按鈕點擊通知多個監聽器）、MVC 架構（Model 通知 View）或發布-訂閱系統。
- 避免在 Observer 固定或變更頻繁的情境中使用；改用事件匯流排如 Spring 的 ApplicationEvent。