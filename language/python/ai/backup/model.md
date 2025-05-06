# Model


## Code
model繼承自 nn.Module 的 PyTorch 模型

* mode：布林值，默認為 True：
  * True：將模型設置為訓練模式。
  * False：等效於 model.eval()，將模型設置為評估模式。

### Train Mode
將模型設置為訓練模式，具體影響以下方面：

#### 啟用 Dropout：
在訓練模式下，nn.Dropout 層會隨機丟棄一部分神經元（以指定的概率），以防止過擬合。
在評估模式（model.eval()）下，Dropout 會被禁用，所有神經元都參與計算，且輸出會根據丟棄概率進行縮放以保持期望值一致。

####  啟用 BatchNorm 的訓練行為：
nn.BatchNorm（批歸一化）層在訓練模式下使用當前批次的均值和方差進行歸一化，並更新全局均值和方差的移動平均。
在評估模式下，BatchNorm 使用訓練過程中學習到的全局均值和方差進行歸一化，且不更新移動平均。

#### 影響其他訓練相關層：
某些自定義層或模組可能根據訓練/評估模式改變行為（例如，某些正則化技術）。

#### 設置模型狀態：
model.train() 將模型及其所有子模組的 training 屬性設置為 True，影響所有層的行為。

#### 為什麼需要？
在訓練過程中，Dropout 和 BatchNorm 等層需要特定的隨機性和動態行為，以增強模型的泛化能力。
在評估或推理過程中，這些層需要確定性行為，以確保輸出穩定且可重現。
model.train() 確保模型在訓練時啟用這些訓練特定行為，而 model.eval() 則禁用它們。

### Eval Mode
評估模式

* Dropout 被禁用，確保推薦分數（pos_score 和 neg_score）是確定性的。
  * 禁用 Dropout，所有元素保留。 
  * 輸出乘以 (1-p) 以補償訓練時的丟棄（確保期望值一致）。

* 如果存在 BatchNorm（您的程式碼中無），會使用訓練時學習到的全局統計數據。
  * 使用訓練時學習到的全局均值和方差進行歸一化。
  * 不更新移動平均


在您的推薦系統程式碼中，`nn.Linear` 和 `nn.Sigmoid` 是 `TransformerRecommender` 模型中的兩個關鍵組件，分別用於線性變換和非線性激活。它們在模型的最後階段處理 Transformer 的輸出，生成最終的匹配分數。以下詳細解釋 `nn.Linear` 和 `nn.Sigmoid` 的作用，並結合您的程式碼（特別是 `TransformerRecommender` 的 `forward` 方法）分析它們在訓練過程中的具體功能。


## Train

---

### 1. `nn.Linear` 的作用

#### 定義
```python
nn.Linear(in_features, out_features, bias=True)
```
- **`in_features`**：輸入張量的最後一維大小（特徵數量）。
- **`out_features`**：輸出張量的最後一維大小（目標特徵數量）。
- **`bias`**：是否包含偏置項（默認為 `True`）。

`nn.Linear` 是一個全連接層（fully connected layer），對輸入張量執行線性變換：
\[ y = xW^T + b \]
- \( x \): 輸入張量，形狀為 `(..., in_features)`。
- \( W \): 權重矩陣，形狀為 `(out_features, in_features)`。
- \( b \): 偏置向量，形狀為 `(out_features,)`。
- \( y \): 輸出張量，形狀為 `(..., out_features)`。

#### 通用作用
- **特徵映射**：將輸入特徵從一個維度（`in_features`）映射到另一個維度（`out_features`）。
- **降維或升維**：根據 `out_features` 的設置，改變特徵的維度。
- **學習線性關係**：通過訓練調整 \( W \) 和 \( b \)，學習輸入與輸出之間的線性關係。
- **應用場景**：常用於神經網絡的最後層（例如，分類或回歸任務），或中間層（例如，Transformer 的前饋網絡）。

#### 在您的程式碼中的具體作用
在 `TransformerRecommender` 模型中，`nn.Linear` 用於將 Transformer Decoder 的輸出轉換為單個分數：

```python
class TransformerRecommender(nn.Module):
    def __init__(self, vector_dim, nhead=4, num_layers=2, hidden_dim=128):
        super(TransformerRecommender, self).__init__()
        self.vector_dim = vector_dim
        
        # Transformer Encoder for user vectors
        encoder_layer = nn.TransformerEncoderLayer(d_model=vector_dim, nhead=nhead, dim_feedforward=hidden_dim)
        self.user_encoder = nn.TransformerEncoder(encoder_layer, num_layers=num_layers)
        
        # Transformer Decoder for article vectors
        decoder_layer = nn.TransformerDecoderLayer(d_model=vector_dim, nhead=nhead, dim_feedforward=hidden_dim)
        self.article_decoder = nn.TransformerDecoder(decoder_layer, num_layers=num_layers)
        
        # Fully connected layer to compute score
        self.fc = nn.Linear(vector_dim, 1)  # 將 vector_dim 映射到單個分數
        self.sigmoid = nn.Sigmoid()

    def forward(self, user_vec, article_vec):
        # user_vec: (batch_size, vector_dim)
        # article_vec: (batch_size, vector_dim)
        
        # 增加序列維度以符合Transformer輸入 (seq_len=1, batch_size, vector_dim)
        user_vec = user_vec.unsqueeze(0)
        article_vec = article_vec.unsqueeze(0)
        
        # Transformer處理
        user_encoded = self.user_encoder(user_vec)
        article_decoded = self.article_decoder(article_vec, user_encoded)
        
        # 移除序列維度並計算分數
        output = self.fc(article_decoded.squeeze(0)).squeeze(-1)  # (batch_size,)
        return self.sigmoid(output)
```

- **配置**：
    - `self.fc = nn.Linear(vector_dim, 1)`：
        - `in_features=vector_dim`（例如，64），對應 Transformer Decoder 輸出的特徵維度。
        - `out_features=1`，將每個樣本的特徵映射到單個分數。
        - `bias=True`，包含偏置項。
- **輸入**：
    - `article_decoded`：Transformer Decoder 的輸出，形狀為 `(1, batch_size, vector_dim)`，例如 `(1, 32, 64)`。
    - `article_decoded.squeeze(0)`：移除序列維度，形狀變為 `(batch_size, vector_dim)`，例如 `(32, 64)`。
- **處理**：
    - `self.fc(article_decoded.squeeze(0))`：
        - 對每個樣本的 64 維特徵（`(32, 64)`）進行線性變換，生成形狀為 `(batch_size, 1)` 的張量，例如 `(32, 1)`。
        - 每個輸出值是一個未激活的分數，表示消費者與文章的匹配程度。
- **輸出**：
    - `self.fc` 的輸出形狀為 `(batch_size, 1)`，經 `squeeze(-1)` 後變為 `(batch_size,)`，例如 `(32,)`。
    - 每個分數對應一個消費者-文章對的預測匹配度。

- **具體作用**：
    - **降維**：將 Transformer Decoder 的高維輸出（64 維）壓縮為單個分數，簡化後續的排序任務。
    - **學習匹配關係**：通過訓練，`nn.Linear` 的權重 \( W \) 和偏置 \( b \) 學習如何從 Transformer 的特徵中提取與消費者偏好相關的信息。
    - **正負樣本分數**：
        - 對於正向樣本（`pos_article_vec`），`nn.Linear` 生成 `pos_score`。
        - 對於負向樣本（`neg_article_vec`），`nn.Linear` 生成 `neg_score`。
        - BPR 損失鼓勵 `pos_score > neg_score`，`nn.Linear` 的參數會調整以實現這一目標。

- **在推薦系統中的意義**：
    - `nn.Linear` 是模型的最後一步，將 Transformer 提取的複雜特徵（消費者與文章的交互表示）轉換為單個分數，用於排序推薦。
    - 例如，對於消費者 0 和點讚文章 10，`nn.Linear` 輸出一個高分（接近 1）；對於未點讚文章 20，輸出一個低分（接近 0）。

---

### 2. `nn.Sigmoid` 的作用

#### 定義
```python
nn.Sigmoid()
```
- `nn.Sigmoid` 是一個激活函數模組，對輸入張量的每個元素應用 sigmoid 函數：
  \[ y = \sigma(x) = \frac{1}{1 + e^{-x}} \]
- 輸入：任意形狀的張量。
- 輸出：形狀與輸入相同，每個元素映射到 \([0, 1]\) 區間。

#### 通用作用
- **概率映射**：將任意實數映射到 \([0, 1]\) 區間，常表示概率或置信度。
- **非線性激活**：引入非線性，使模型能夠學習複雜的模式。
- **應用場景**：
    - 二分類任務：輸出概率（例如，點讚/未點讚）。
    - 排序任務：規範化分數，方便比較。
    - 激活函數：在神經網絡中引入非線性（儘管現代常用 ReLU 等）。

#### 在您的程式碼中的具體作用
在 `TransformerRecommender` 模型中，`nn.Sigmoid` 用於將 `nn.Linear` 的輸出規範化到 \([0, 1]\) 區間：

- **配置**：
    - `self.sigmoid = nn.Sigmoid()`：定義 sigmoid 激活函數。
- **輸入**：
    - `self.fc` 的輸出，經過 `squeeze(-1)` 後，形狀為 `(batch_size,)`，例如 `(32,)`。
    - 每個元素是一個未激活的分數（實數範圍）。
- **處理**：
    - `self.sigmoid(output)`：
        - 對每個分數應用 sigmoid 函數，將其映射到 \([0, 1]\)。
        - 輸出形狀保持為 `(batch_size,)`，例如 `(32,)`。
- **輸出**：
    - 每個分數表示消費者對文章的匹配概率（或偏好程度），範圍在 \([0, 1]\)。
    - 例如，`pos_score` 和 `neg_score` 分別表示正向和負向樣本的匹配概率。

- **具體作用**：
    - **規範化分數**：將 `nn.Linear` 的任意實數輸出轉為 \([0, 1]\) 區間，使分數更具可解釋性（類似概率）。
    - **支援 BPR 損失**：
        - BPR 損失（`bpr_loss`）基於 `pos_score - neg_score` 的 sigmoid 值：
          ```python
          def bpr_loss(pos_score, neg_score):
              return -torch.mean(torch.log(torch.sigmoid(pos_score - neg_score)))
          ```
        - `nn.Sigmoid` 確保 `pos_score` 和 `neg_score` 在 \([0, 1]\) 區間，與 `bpr_loss` 中的 `sigmoid` 函數兼容，穩定損失計算。
    - **正負樣本比較**：
        - `pos_score`（正向樣本）應接近 1，表示高匹配度。
        - `neg_score`（負向樣本）應接近 0，表示低匹配度。
        - `nn.Sigmoid` 幫助模型輸出符合這一預期的分數。

- **在推薦系統中的意義**：
    - `nn.Sigmoid` 將 Transformer 和 `nn.Linear` 的輸出轉為標準化的匹配分數，方便比較正向和負向樣本的偏好。
    - 例如，對於消費者 0，`pos_score[0]`（對點讚文章 10）可能接近 0.9，`neg_score[0]`（對未點讚文章 20）可能接近 0.2，反映偏好排序。

---

### 在訓練過程中的具體對應

在訓練迴圈中，`nn.Linear` 和 `nn.Sigmoid` 與 `LikeDataset` 的三個張量（`user_vec`, `pos_article_vec`, `neg_article_vec`）的對應如下：

#### 訓練迴圈
```python
for user_vec, pos_article_vec, neg_article_vec in dataloader:
    user_vec = user_vec.to(device)
    pos_article_vec = pos_article_vec.to(device)
    neg_article_vec = neg_article_vec.to(device)
    
    # 正向和負向分數
    pos_score = model(user_vec, pos_article_vec)
    neg_score = model(user_vec, neg_article_vec)
    
    # 計算BPR損失
    loss = bpr_loss(pos_score, neg_score)
    
    # 反向傳播
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()
```

#### 對應過程
1. **輸入張量**：
    - `DataLoader` 提供批次張量：
        - `user_vec`：`(batch_size, vector_dim)`，例如 `(32, 64)`，表示 32 個消費者向量。
        - `pos_article_vec`：`(32, 64)`，表示 32 個點讚文章向量。
        - `neg_article_vec`：`(32, 64)`，表示 32 個未點讚文章向量。
    - 這些張量保持索引對應，例如，`user_vec[i]`, `pos_article_vec[i]`, `neg_article_vec[i]` 屬於同一個訓練樣本。

2. **正向樣本處理**：
    - `pos_score = model(user_vec, pos_article_vec)`：
        - `user_vec` 通過 `user_encoder` 生成 `user_encoded`（`(1, 32, 64)`）。
        - `pos_article_vec` 通過 `article_decoder`（以 `user_encoded` 為記憶）生成 `article_decoded`（`(1, 32, 64)`）。
        - `article_decoded.squeeze(0)`：形狀變為 `(32, 64)`。
        - **`nn.Linear`**：`self.fc` 將 `(32, 64)` 映射到 `(32, 1)`，每個樣本生成一個未激活分數。
        - **`nn.Sigmoid`**：`self.sigmoid` 將 `(32, 1)` 映射到 `(32,)`，每個分數在 \([0, 1]\)，表示正向樣本的匹配概率。
        - 例如，`pos_score[i]` 是 `user_vec[i]`（消費者 i）對 `pos_article_vec[i]`（點讚文章）的預測分數。

3. **負向樣本處理**：
    - `neg_score = model(user_vec, neg_article_vec)`：
        - 使用相同的 `user_vec`，確保消費者一致。
        - `neg_article_vec` 通過相同的處理流程（`article_decoder`, `nn.Linear`, `nn.Sigmoid`）生成 `neg_score`（`(32,)`）。
        - 例如，`neg_score[i]` 是 `user_vec[i]`（消費者 i）對 `neg_article_vec[i]`（未點讚文章）的預測分數。

4. **BPR 損失計算**：
    - `loss = bpr_loss(pos_score, neg_score)`：
        - 損失計算 `pos_score[i] - neg_score[i]` 的 sigmoid 對數，鼓勵 `pos_score[i] > neg_score[i]`。
        - `nn.Sigmoid` 確保分數在 \([0, 1]\)，與 BPR 損失的 sigmoid 函數兼容。
        - 損失基於 32 個正負對，反映批次中所有樣本的排序質量。

5. **參數更新**：
    - `loss.backward()` 計算梯度，包括 `nn.Linear` 的權重和偏置（`self.fc.weight`, `self.fc.bias`）。
    - `optimizer.step()` 更新參數，使 `pos_score` 更高，`neg_score` 更低。
    - `nn.Linear` 的權重學習如何從 Transformer 特徵中提取排序信息，`nn.Sigmoid` 確保輸出分數的範圍適合 BPR 損失。

---

### 注意事項

1. **形狀一致性**：
    - `nn.Linear` 的輸入維度（`vector_dim=64`）必須與 Transformer Decoder 的輸出維度匹配。
    - `nn.Sigmoid` 不改變形狀，但確保輸出在 \([0, 1]\)。
    - 檢查：
      ```python
      print(article_decoded.squeeze(0).shape)  # 應為 (32, 64)
      print(self.fc(article_decoded.squeeze(0)).shape)  # 應為 (32, 1)
      ```

2. **分數範圍**：
    - `nn.Sigmoid` 將分數規範化到 \([0, 1]\)，這對於 BPR 損失的穩定性至關重要。
    - 如果不需要 \([0, 1]\) 範圍（例如，直接用原始分數），可以移除 `nn.Sigmoid`，但需調整 `bpr_loss` 的實現。

3. **梯度計算**：
    - `nn.Linear` 的參數（權重和偏置）是可訓練的，通過 `loss.backward()` 更新。
    - `nn.Sigmoid` 是無參數的激活函數，僅影響梯度傳播（sigmoid 的梯度範圍較小，可能導致梯度消失，需注意學習率）。

4. **BPR 損失的兼容性**：
    - `nn.Sigmoid` 的輸出與 `bpr_loss` 中的 `torch.sigmoid` 配合，確保損失計算穩定。
    - 如果 `pos_score` 或 `neg_score` 出現 `NaN` 或 `inf`，檢查 Transformer 輸出或數據是否有異常。

5. **真實數據的應用**：
    - 在真實數據中，`nn.Linear` 和 `nn.Sigmoid` 的作用保持不變，將高維特徵轉為匹配分數。
    - 確保 `vector_dim` 與真實數據的向量維度一致（例如，64 維）。

---

### 在推薦系統中的具體意義

在您的 Transformer-based 推薦系統中，`nn.Linear` 和 `nn.Sigmoid` 的作用如下：
- **`nn.Linear`**：
    - 將 Transformer Decoder 的高維特徵（`(32, 64)`）降維為單個分數（`(32, 1)`），提取消費者與文章的匹配程度。
    - 學習如何從 Transformer 特徵中計算排序分數，適應點讚紀錄的偏好。
    - 例如，對於消費者 0 和點讚文章 10，`nn.Linear` 輸出高分；對於未點讚文章 20，輸出低分。
- **`nn.Sigmoid`**：
    - 將 `nn.Linear` 的輸出規範化到 \([0, 1]\)，表示匹配概率，方便比較正負樣本。
    - 與 BPR 損失兼容，確保正向分數（`pos_score`）接近 1，負向分數（`neg_score`）接近 0。
- **與三個張量的對應**：
    - `user_vec[i]` 和 `pos_article_vec[i]` 通過 Transformer 和 `nn.Linear`/`nn.Sigmoid` 生成 `pos_score[i]`，表示點讚偏好。
    - `user_vec[i]` 和 `neg_article_vec[i]` 生成 `neg_score[i]`，表示低偏好。
    - BPR 損失基於這些分數優化模型，確保正向樣本的排序高於負向樣本。

---

### 總結

- **`nn.Linear`**：
    - 將 Transformer Decoder 的高維特徵（`(batch_size, vector_dim)`）映射到單個分數（`(batch_size, 1)`），學習消費者與文章的匹配關係。
    - 在訓練中，調整權重和偏置，使正向樣本分數高於負向樣本。
- **`nn.Sigmoid`**：
    - 將 `nn.Linear` 的輸出規範化到 \([0, 1]\)，表示匹配概率，支援 BPR 損失的計算。
    - 確保正向分數（`pos_score`）接近 1，負向分數（`neg_score`）接近 0。
- **與三個張量的對應**：
    - `user_vec` 和 `pos_article_vec` 通過 `TransformerRecommender` 生成 `pos_score`，對應點讚紀錄的正向樣本。
    - `user_vec` 和 `neg_article_vec` 生成 `neg_score`，對應隨機未點讚的負向樣本。
    - `nn.Linear` 和 `nn.Sigmoid` 將 Transformer 特徵轉為最終分數，BPR 損失基於這些分數優化模型。

如果您有更多問題（例如，如何調整 `nn.Linear` 的輸出維度、優化 sigmoid 的影響，或處理真實數據），請提供細節，我可以進一步協助！

