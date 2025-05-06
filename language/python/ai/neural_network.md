# Neural Network

## 概念快速總覽

| 架構                                            | 核心用途             | 運作方式簡介                 |
|-----------------------------------------------|------------------|------------------------|
| CNN                                           | 擅長捕捉區域性的特徵       | 卷積操作擷取鄰近區域資訊           |
| RNN                                           | 擅長處理時序性、順序資訊     | 一步步處理序列，前一步輸出影響後一步     |
| Self-Attention([Transformer](transformer.md)) | 擅長抓出序列中任意位置之間的關聯 | 每個位置都可關注任意其他位置，計算注意力權重 |

## 核心比較表

| 特性/架構        | CNN              | RNN         | Self-Attention / [Transformer](transformer.md) |
|--------------|------------------|-------------|------------------------------------------------|
| 🚀 並行運算能力    | 很高               | 低（序列依賴）     | 高（全部可以同時計算）                                    |
| 🧠 記憶長距離關係能力 | 差（只能看鄰近區域）       | 中（會忘記長距離資訊） | 強（可直接學到任意位置的關係）                                |
| 🧩 適用資料類型    | 影像、NLP中提取 N-gram | 語音、NLP、時間序列 | NLP（翻譯、對話、摘要、分類等）                              |
| 🔢 模型結構      | 固定大小卷積核          | 單步輸入、時間遞迴   | 全部序列一次輸入，注意力加權                                 |
| 🧱 可解釋性      | 中（可以觀察 filter）   | 差（難解釋記憶過程）  | 好（注意力分數能看出模型關注重點）                              |
| 📈 訓練穩定性     | 穩定（梯度不易爆炸）       | 容易梯度爆炸/消失   | 穩定（搭配 LayerNorm & Multi-head）                  |
| 🧮 記憶效率      | 高                | 中           | 低（長序列時計算量為 O(n²)）                              |

## 架構實作
用圖片辨識當範例

在 PyTorch 中，不同的神經網路模型架構（如 CNN 或 Transformer）通常都繼承自 nn.Module，並主要透過 __init__ 和 forward 這兩個方法來定義模型的結構和前向傳播邏輯。

### nn.Module 的角色
nn.Module 是 PyTorch 中所有神經網路模組的基類，提供了許多方便的功能，例如：

* 參數管理：自動追蹤模型中的參數（nn.Parameter）和子模組（nn.Module 實例）。
* 層次結構：支援模組的嵌套，讓你能輕鬆構建複雜的網路。
* 前向傳播：透過 forward 方法定義模型的計算流程。
* 設備管理：支援 .to(device) 將模型和參數移動到 GPU 或 CPU。
* 其他方法：如 .train()、.eval() 用於切換訓練/評估模式。

當你定義一個自訂神經網路模型時，繼承 nn.Module 並實作 __init__ 和 forward 方法是標準做法，因為這兩個方法涵蓋了模型結構的初始化和計算邏輯。

### __init__ 的作用
__init__ 方法用於初始化模型的結構，包括：

* 定義模型的層（layers），如卷積層（nn.Conv2d）、全連接層（nn.Linear）、注意力機制等。
* 註冊子模組（submodules）或參數，這些會被 nn.Module 自動追蹤。
* 設置超參數（例如濾波器數量、隱藏層大小等）。

範例：CNN 和 VIT 的 __init__
假設你有一個簡單的 CNN 和 VisionTransformer，它們的 __init__ 可能如下：
```
import torch
import torch.nn as nn

# CNN 模型
class CNN(nn.Module):
    def __init__(self, num_classes):
        super(CNN, self).__init__()  # 呼叫 nn.Module 的 __init__
        self.conv1 = nn.Conv2d(in_channels=3, out_channels=16, kernel_size=3, padding=1)
        self.relu = nn.ReLU()
        self.pool = nn.MaxPool2d(kernel_size=2, stride=2)
        self.fc = nn.Linear(16 * 16 * 16, num_classes)  # 假設輸入圖像大小為 32x32

# VisionTransformer 模型
class VisionTransformer(nn.Module):
    def __init__(self, num_classes, patch_size=16, num_patches=196, embed_dim=768):
        super(VisionTransformer, self).__init__()
        self.patch_embed = nn.Linear(patch_size * patch_size * 3, embed_dim)
        self.transformer = nn.TransformerEncoder(
            nn.TransformerEncoderLayer(d_model=embed_dim, nhead=8), num_layers=6
        )
        self.fc = nn.Linear(embed_dim, num_classes)
```
* CNN 的 __init__ 定義了卷積層、池化層和全連接層，這些是 CNN 的核心組件。
* VisionTransformer 的 __init__ 定義了將圖像分塊嵌入（patch embedding）、Transformer 編碼器和分類層，這些是 ViT 的核心組件。
* 兩者都繼承 nn.Module，並透過 super().__init__() 確保父類的初始化邏輯被執行

### forward 的作用
forward 方法定義了模型的前向傳播邏輯，即輸入資料如何經過各層進行計算並產生輸出。PyTorch 會在你呼叫模型實例（例如 model(input)）時自動調用 forward 方法。

範例：CNN 和 VIT 的 forward，接續上面的例子，forward 方法可能如下：
```
# CNN 模型
class CNN(nn.Module):
    def __init__(self, num_classes):
        super(CNN, self).__init__()
        self.conv1 = nn.Conv2d(in_channels=3, out_channels=16, kernel_size=3, padding=1)
        self.relu = nn.ReLU()
        self.pool = nn.MaxPool2d(kernel_size=2, stride=2)
        self.fc = nn.Linear(16 * 16 * 16, num_classes)

    def forward(self, x):
        x = self.conv1(x)  # 卷積
        x = self.relu(x)   # 激活
        x = self.pool(x)   # 池化
        x = x.view(x.size(0), -1)  # 展平
        x = self.fc(x)     # 全連接層
        return x

# VisionTransformer 模型
class VisionTransformer(nn.Module):
    def __init__(self, num_classes, patch_size=16, num_patches=196, embed_dim=768):
        super(VisionTransformer, self).__init__()
        self.patch_embed = nn.Linear(patch_size * patch_size * 3, embed_dim)
        self.transformer = nn.TransformerEncoder(
            nn.TransformerEncoderLayer(d_model=embed_dim, nhead=8), num_layers=6
        )
        self.fc = nn.Linear(embed_dim, num_classes)

    def forward(self, x):
        # 假設 x 為 (batch_size, 3, H, W)
        batch_size = x.size(0)
        x = x.view(batch_size, -1, self.patch_size * self.patch_size * 3)  # 分塊
        x = self.patch_embed(x)  # 嵌入
        x = self.transformer(x)  # Transformer 處理
        x = x.mean(dim=1)  # 平均池化或取 [CLS] token
        x = self.fc(x)  # 分類
        return x
```
* CNN 的 forward 描述了輸入圖像如何經過卷積、激活、池化、展平和全連接層，產生分類輸出。
* VisionTransformer 的 forward 描述了輸入圖像如何被分塊、嵌入、經過 Transformer 編碼器處理，最後透過全連接層進行分類。
* 兩者的邏輯完全不同，但都透過 forward 方法定義了輸入到輸出的計算流程。

### 為什麼 __init__ 和 forward 足以實現不同架構？
__init__ 和 forward 的組合提供了高度的靈活性，讓你可以定義幾乎任何神經網路架構：

* __init__ 的模組化：你可以在 __init__ 中自由組合 PyTorch 提供的模組（nn.Conv2d、nn.Linear、nn.Transformer 等）或自訂模組，構建任意複雜的結構。
* forward 的靈活性：forward 方法允許你定義任意的前向傳播邏輯，包括非線性操作、條件分支、迴圈等。例如，ViT 需要將圖像分塊並進行 Transformer 處理，而 CNN 則專注於局部特徵提取，這都可以透過 forward 實現。
* PyTorch 的動態計算圖：PyTorch 的動態計算圖（eager mode）讓 forward 的執行是即時的，無需提前編譯計算圖，這使得不同架構的實現更加簡單。
  此外，nn.Module 的繼承提供了統一的介面，讓不同模型（如 CNN 和 ViT）都能使用相同的訓練流程（例如優化器、損失函NUMBER、.to(device) 等），無需為每個模型重寫這些邏輯。

### 其他方法（非必要）
雖然 __init__ 和 forward 是核心，但有些模型可能會實作其他方法來增強功能：
* 自訂方法：例如 get_features 用於提取中間特徵，或 reset_parameters 用於自訂參數初始化。
* 覆寫其他 nn.Module 方法：例如 extra_repr 用於自訂模型的字串表示。
* 鉤子（hooks）：用於監控中間層的輸出或梯度，但這通常不是模型架構的核心。
  這些方法是可選的，對於大多數模型，__init__ 和 forward 已經足夠。

### CNN 和 VIT 的區別
雖然兩者都繼承 nn.Module 並使用 __init__ 和 forward，它們的設計理念和計算流程完全不同：

#### CNN：
* __init__：主要定義卷積層、池化層和全連接層，強調局部特徵提取。
* forward：按層次順序處理（卷積 → 激活 → 池化 → 展平 → 分類）。
* 適用於圖像資料，擅長捕捉空間層次結構。

#### VIT：
* __init__：定義分塊嵌入、Transformer 編碼器和分類層，強調全局上下文建模。
* forward：將圖像分塊後進行序列化處理，透過注意力機制捕捉全局關係。
* 適用於需要全局建模的任務，特別在大型資料集上有優勢。

## 名詞解釋
### CLS Token
CLS token 是一個可學習的向量，添加到輸入序列的開頭（或其他固定位置），用於捕獲整個序列的全局信息。在 Transformer 模型中，輸入通常是一個序列（例如文字的單詞嵌入或圖像的 patch 嵌入），而 Transformer 的自注意力機制會計算序列中每個元素（token）之間的關係。CLS token 通過與其他 token 交互，聚合序列的上下文信息，最終用於下游任務（如分類）。

* 在 NLP 中：例如 BERT，CLS token 是一個特殊的 [CLS] 標記，添加到輸入句子的開頭，其輸出用於句子級分類任務（例如情感分析）。
* 在圖像處理中：例如 VIT，CLS token 是一個額外的嵌入向量，與圖像分割後的 patch 嵌入一起輸入 Transformer，輸出用於圖像分類。