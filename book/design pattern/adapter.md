# Adapter 設計模式的介紹

Adapter 設計模式（適配器模式）是一種結構型設計模式，它將一個類別的介面轉換為客戶端期望的另一個介面，讓原本不相容的類別能夠合作。這種模式像是一個「轉接頭」，讓舊系統或第三方庫的介面與新系統相容，而無需修改原有類別的程式碼。它有兩種主要形式：類別適配器（使用繼承）和物件適配器（使用組合），後者更靈活。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Adapter 模式的核心動機是解決介面不相容問題，避免直接修改不可變的舊類別。例如，在媒體播放器應用中，現有系統支援 MP3，但新增 VLC 格式時，您可以使用 Adapter 將 VLC 播放器適配到現有介面，讓客戶端無需改變。這促進了系統的擴展性與重用性。

主要優點包括：
- **相容性**：讓舊介面與新系統整合。
- **單一責任**：Adapter 只負責轉換，不影響原有類別。
- **靈活性**：物件適配器支援多重繼承效果。

## 結構

Adapter 模式涉及四個主要組件（以物件適配器為例）：

| 組件          | 描述                                            |
|-------------|-----------------------------------------------|
| **Target**  | 目標介面，客戶端期望的介面（例如 MediaPlayer 的 `play()`）。     |
| **Adapter** | 適配器，實作 Target，並組合 Adaptee，將請求轉換為 Adaptee 的方法。 |
| **Adaptee** | 被適配類別，擁有不相容介面（例如 VlcPlayer 的 `playVlc()`）。    |
| **Client**  | 客戶端，透過 Target 介面使用 Adapter。                   |

互動流程：
1. 客戶端呼叫 Target 的方法。
2. Adapter 接收呼叫，並轉發到 Adaptee 的對應方法。
3. Adaptee 執行實際邏輯。

## Java 範例

以下是簡單的媒體播放器範例（MediaPlayer 作為 Target），使用 Adapter 將 VLC 播放器（Adaptee）適配到系統中：

```java
// Target 介面
interface MediaPlayer {
    void play(String audioType, String fileName);
}

// Adaptee（舊 VLC 播放器類別）
class VlcPlayer {
    public void playVlc(String fileName) {
        System.out.println("Playing vlc file: " + fileName);
    }

    // 假設還有其他 VLC 專屬方法
    public void playVlcSpecific(String fileName) {
        System.out.println("Playing specific VLC format: " + fileName);
    }
}

// Adapter（物件適配器）
class MediaAdapter implements MediaPlayer {
    private VlcPlayer vlcPlayer;

    public MediaAdapter() {
        vlcPlayer = new VlcPlayer();
    }

    @Override
    public void play(String audioType, String fileName) {
        if (audioType.equalsIgnoreCase("vlc")) {
            vlcPlayer.playVlc(fileName);
        } else if (audioType.equalsIgnoreCase("vlc_specific")) {
            vlcPlayer.playVlcSpecific(fileName);
        } else {
            System.out.println("Unsupported format: " + audioType);
        }
    }
}

// Client（進階播放器，內部使用 Adapter）
class AdvancedMediaPlayer implements MediaPlayer {
    private MediaAdapter mediaAdapter;

    @Override
    public void play(String audioType, String fileName) {
        if (audioType.equalsIgnoreCase("mp3")) {
            System.out.println("Playing mp3 file: " + fileName);  // 內建支援
        } else {
            mediaAdapter = new MediaAdapter();  // 動態建立 Adapter
            mediaAdapter.play(audioType, fileName);
        }
    }
}

// 使用範例
public class AdapterDemo {
    public static void main(String[] args) {
        AdvancedMediaPlayer player = new AdvancedMediaPlayer();

        player.play("mp3", "song.mp3");          // 輸出: Playing mp3 file: song.mp3
        player.play("vlc", "movie.vlc");         // 輸出: Playing vlc file: movie.vlc
        player.play("vlc_specific", "special.vlc");  // 輸出: Playing specific VLC format: special.vlc
    }
}
```

此範例展示 AdvancedMediaPlayer 如何透過 Adapter 支援 VLC，而無需修改 VlcPlayer。輸出顯示不同格式的播放結果。

## 優點與缺點

| 優點                | 缺點                    |
|-------------------|-----------------------|
| 讓不相容介面合作，易整合舊系統。  | 增加額外類別，略增複雜度。         |
| 符合開放/封閉原則，不改原有類別。 | 轉換邏輯可能複雜，若介面差異大需額外處理。 |
| 物件適配器支援組合，靈活。     | 類別適配器受限於單一繼承。         |

## 何時使用
- 當需讓兩個不相容介面合作，或整合第三方庫時。
- 適用於媒體轉換器、資料格式適配（JSON to XML）或舊 API 包裝。
- 避免在介面已相容或簡單轉換的情境中使用，以防過度設計。
