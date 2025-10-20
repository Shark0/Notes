# Facade 設計模式的介紹

Facade 設計模式（門面模式）是一種結構型設計模式，它提供了一個簡化的介面，讓子系統的一組介面變得更容易使用。這種模式透過一個高層次的門面類別，隱藏子系統的複雜性，讓客戶端只需與門面互動，而無需了解後端的細節。Facade 就像一棟大樓的正門，隱藏了內部的電梯、樓梯等複雜結構。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Facade 模式的核心動機是簡化對複雜子系統的存取，避免客戶端直接處理多個類別的互動。這有助於降低耦合度，並促進鬆散耦合的架構。例如，在多媒體系統中，播放音樂可能涉及解碼器、音頻處理器和揚聲器等子系統；Facade 可以提供一個簡單的 `play()` 方法，隱藏這些細節，讓客戶端輕鬆使用。

主要優點包括：
- **簡化介面**：客戶端只需一個入口點，減少學習曲線。
- **降低耦合**：子系統內部變更不影響客戶端。
- **易於維護**：集中管理子系統互動邏輯。

## 結構

Facade 模式涉及四個主要組件：

| 組件                    | 描述                                        |
|-----------------------|-------------------------------------------|
| **Facade**            | 門面類別，提供簡化方法，協調子系統物件的互動（例如 `playMusic()`）。 |
| **Subsystem Classes** | 子系統的具體類別，提供實際功能（例如解碼器、音頻處理器），但客戶端不直接使用。   |
| **Client**            | 客戶端，僅透過 Facade 存取子系統，無需知道內部細節。            |
| **Compiler**          | （選用）若子系統需初始化，Facade 可負責協調。                |

互動流程：
1. 客戶端呼叫 Facade 的高層方法。
2. Facade 建立或取得子系統物件。
3. Facade 依序呼叫子系統方法，完成操作。
4. 結果回傳給客戶端。

## Java 範例

以下是簡單的多媒體播放系統範例（MultimediaFacade 作為 Facade），隱藏解碼器（Decoder）和音頻處理器（AudioProcessor）的複雜性：

```java
// 子系統類別 1
class Decoder {
    public void decode(String file) {
        System.out.println("Decoding file: " + file);
    }
}

// 子系統類別 2
class AudioProcessor {
    public void process(String data) {
        System.out.println("Processing audio data: " + data);
    }
}

// 子系統類別 3
class Speaker {
    public void play() {
        System.out.println("Playing audio through speaker");
    }
}

// Facade
class MultimediaFacade {
    private Decoder decoder = new Decoder();
    private AudioProcessor processor = new AudioProcessor();
    private Speaker speaker = new Speaker();

    public void playMusic(String file) {
        // 協調子系統
        decoder.decode(file);
        processor.process("decoded data");
        speaker.play();
    }
}

// 使用範例
public class FacadeDemo {
    public static void main(String[] args) {
        MultimediaFacade facade = new MultimediaFacade();

        // 客戶端只需一個方法
        facade.playMusic("song.mp3");
        // 輸出:
        // Decoding file: song.mp3
        // Processing audio data: decoded data
        // Playing audio through speaker
    }
}
```

此範例展示 Facade 如何簡化播放流程，客戶端無需直接管理三個子系統。

## 優點與缺點

| 優點              | 缺點                                    |
|-----------------|---------------------------------------|
| 提供簡單介面，降低使用複雜度。 | Facade 可能變得過大，成為單一責任違反的「大泥球」。         |
| 促進子系統間的鬆散耦合。    | 限制客戶端對子系統的細粒度控制（若需特定功能，可能需繞過 Facade）。 |
| 易於測試與重構子系統。     | 過多 Facade 可能導致程式碼重複。                  |

## 何時使用

- 當子系統複雜且客戶端只需部分功能時。
- 適用於 API 封裝（例如庫的門面）、多層架構（業務邏輯隱藏資料存取）或微服務閘道。
- 避免在子系統簡單或需高度自訂時使用，以防不必要的抽象層。
