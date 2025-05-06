# Loss Function

## Description
在機器學習中，Loss Function扮演了核心角色，它是模型訓練過程中的關鍵組件，用來量化模型預測與真實結果之間的誤差。以下是損失函數在機器學習中的主要角色和功能

### 衡量模型表現
損失函數提供了一個數值指標，用來評估模型預測值與真實值之間的差距。例如：
* 在回歸任務中，均方誤差（MSE）計算預測值與真實值的平方差。
* 在分類任務中，交叉熵損失衡量預測概率分佈與真實標籤的差異。

這使得我們可以客觀比較模型的表現，並判斷其是否需要改進。

### 引導模型優化
損失函數是優化算法（如梯度下降）的核心依據：
* 模型通過最小化損失函數來調整參數（如權重和偏差）。
* 優化算法根據損失函數的梯度，逐步更新模型參數，使預測結果更接近真實值。

換句話說，損失函數定義了模型學習的「目標」，引導模型朝著正確的方向改進。

### 適應不同任務
損失函數可以根據任務類型和問題特性進行選擇或設計：
* 回歸任務：如均方誤差（MSE）、平均絕對誤差（MAE）。
* 分類任務：如交叉熵損失、Hinge Loss。
* 圖像分割：如Dice Loss、IoU Loss。
* 生成模型：如GAN Loss、Wasserstein Loss。

通過選擇合適的損失函數，模型能夠更好地適應特定任務的需求，例如處理類別不平衡、異常值或生成高質量圖像。

### 平衡模型的偏差與方差
損失函數可以通過正則化項（如L1、L2正則化）來控制模型的複雜度：
* 防止過擬合：正則化項懲罰過大的參數，促使模型學習更簡單的模式。
* 提高泛化能力：損失函數的設計影響模型在未知數據上的表現。

### 支持多目標優化
在一些複雜任務中，損失函數可以是多個子損失的組合。例如：
* 在生成對抗網絡（GAN）中，損失函數同時考慮生成器和判別器的目標。
* 在多任務學習中，損失函數可能結合分類損失和回歸損失，平衡不同任務的表現。

這種靈活性使損失函數能夠應對多維度的優化需求。

### 影響訓練穩定性與收斂
損失函數的選擇直接影響訓練過程的穩定性和收斂速度：
* 平滑的損失函數（如MSE）有利於梯度下降的穩定收斂。
* 非平滑或對異常值敏感的損失函數（如MAE）可能導致訓練不穩定。
* 針對特定問題的損失函數（如Focal Loss）可以加速收斂並提高性能。

## Category
### 回歸任務的損失函數
用於預測連續值的任務。

* 均方誤差（Mean Squared Error, MSE）：預測值與真實值差的平方平均。
* 均方根誤差（Root Mean Squared Error, RMSE）：MSE的平方根。
* 平均絕對誤差（Mean Absolute Error, MAE）：預測值與真實值差的絕對值平均。
* Huber Loss：結合MSE和MAE，對異常值不敏感。
* Log-Cosh Loss：對小誤差近似MSE，對大誤差近似MAE，平滑性更好。
* Quantile Loss：用於分位數回歸，針對特定分位數進行優化

### 分類任務的損失函數
用於預測離散類別的任務。

* 交叉熵損失（Cross-Entropy Loss）：
  * 二分類：二元交叉熵（Binary Cross-Entropy）。
  * 多分類：分類交叉熵（Categorical Cross-Entropy）或稀疏分類交叉熵（Sparse Categorical Cross-Entropy）。
* Hinge Loss：用於支持向量機（SVM）或二分類問題。
* Focal Loss：解決類別不平衡問題，特別適用於目標檢測。
* Kullback-Leibler散度（KL Divergence）：衡量兩個概率分布的差異，常用於變分自編碼器。
* Softmax Loss：交叉熵損失的變體，常用於多分類。

### 生成模型的損失函數
用於生成對抗網絡（GAN）或變分自編碼器（VAE）等。

* GAN Loss：包括生成器和判別器的對抗損失（如最小最大損失）。
* Wasserstein Loss：用於WGAN，基於Wasserstein距離。
* 重構損失（Reconstruction Loss）：如自編碼器中的MSE或BCE。
* 最大均值差異（Maximum Mean Discrepancy, MMD）：用於生成模型的分布匹配。

### 序列建模的損失函數
用於自然語言處理或時間序列任務。

* CTC Loss（Connectionist Temporal Classification）：用於序列對齊，如語音識別。
* Sequence-to-Sequence Loss：用於機器翻譯等，基於交叉熵。

### 圖像處理的損失函數
用於圖像分割、生成或超分辨率等任務。

* Dice Loss：用於圖像分割，特別是醫療圖像，解決類別不平衡。
* IoU Loss（Intersection over Union）：用於分割任務，基於交並比。
* 感知損失（Perceptual Loss）：基於預訓練網絡的特徵距離，用於圖像生成。
* SSIM Loss（Structural Similarity Index）：用於圖像質量評估。

### 其他定制損失函數
* 對比損失（Contrastive Loss）：用於度量學習或Siamese網絡。
* Triplet Loss：用於學習嵌入空間，如人臉識別。
* 自定義損失：根據特定任務設計，例如結合多個損失（如L1 + L2正則化）或領域知識。

## Backpropagation
`loss.backward()` 是 PyTorch 中用來計算梯度的函數。它根據損失函數（`loss`）的值，通過自動求導（autograd）機制，計算出損失對模型中所有需要梯度的參數（`requires_grad=True`）的偏導數（梯度）。這些梯度儲存在每個參數的 `.grad` 屬性中，供優化器使用。

### 核心概念
#### 反向傳播（Backpropagation）
- 反向傳播是一種計算梯度的算法，利用鏈式法則從輸出層（損失函數）向輸入層逐步計算梯度。
- 損失函數 \( L \) 是模型參數 \(\theta\) 的函數，`loss.backward()` 計算 \(\frac{\partial L}{\partial \theta}\)。

#### 自動求導（Autograd）
- PyTorch 的 autograd 引擎會自動追蹤所有張量上的操作（例如，加法、乘法、激活函數），並構建一個計算圖（computational graph）。
- 當調用 `loss.backward()` 時，PyTorch 會遍歷計算圖，從損失開始反向計算每個參數的梯度。

#### 梯度儲存
- 計算出的梯度會累積到每個參數的 `.grad` 屬性中。
- 如果不手動清零（例如，通過 `optimizer.zero_grad()`），梯度會與之前的梯度相加。

---

## `loss.backward()` 在程式碼中的作用

在您的推薦系統程式碼中，`loss.backward()` 出現在訓練迴圈中，用於計算 BPR 損失對 Transformer 模型參數的梯度。以下是相關程式碼片段和具體解釋：

### 具體作用
#### 計算損失的梯度
- `loss = bpr_loss(pos_score, neg_score)` 計算了 BPR（Bayesian Personalized Ranking）損失，該損失衡量正向樣本（點讚文章）的分數是否高於負向樣本（未點讚文章）。
- `loss` 是一個標量張量，表示當前批次的損失值。
- `loss.backward()` 根據 `loss` 的值，計算損失對模型中所有參數（例如，Transformer Encoder 和 Decoder 的權重、線性層的參數）的梯度。

#### 構建計算圖
- 在前向傳播（`pos_score = model(val1_vec, val2_vec)` 和 `neg_score = model(val1_vec, val2_vec)`）中，PyTorch 記錄了從輸入張量到 `loss` 的所有操作，形成了計算圖。
- `loss.backward()` 遍歷這個計算圖，從 `loss` 開始，應用鏈式法則計算梯度，逐步傳播到模型參數。

#### 梯度儲存
- 計算出的梯度儲存在每個參數的 `.grad` 屬性中。例如，對於某個權重矩陣 `weight`，其梯度儲存在 `weight.grad` 中。
- 這些梯度表示損失如何隨著參數變化，指導優化器（Adam）調整參數以降低損失。

#### 與其他部分的關係
- **前置步驟**：`optimizer.zero_grad()` 在 `loss.backward()` 之前調用，清零之前的梯度，確保當前批次的梯度不與之前批次混淆。
- **後續步驟**：`optimizer.step()` 使用計算出的梯度更新模型參數，按照 Adam 優化器的規則調整權重。

## 梯度
grad 是 梯度（gradient） 的縮寫。在機器學習和深度學習中，特別是在使用像 PyTorch 或 TensorFlow 這樣的框架時，grad 通常指某個張量（tensor）對損失函數的梯度，即損失函數對該張量的偏導數。

梯度：梯度是一個向量，表示損失函數𝐿對某個參數（如權重或輸入）的變化率。在反向傳播（backward propagation）中，梯度用來指導參數如何更新以最小化損失。

在 PyTorch 中，當你對一個張量設置 requires_grad=True 並計算損失後，調用 loss.backward() 會自動計算損失對該張量的梯度，並將結果存儲在張量的 .grad 屬性中。
例如，在之前的 Binary Cross-Entropy 範例中，logits.grad 儲存了損失對 logits 的梯度。
### 重要性
* 參數更新：梯度是優化算法（如梯度下降）的核心，參數會沿著梯度的反方向更新，例如： 參數=參數−學習率×梯度
* 診斷訓練問題：檢查 .grad 的值可以幫助判斷梯度是否過大（可能導致爆炸）或過小（可能導致消失）。

### 注意事項
* 梯度累加：在 PyTorch 中，梯度預設是累加的，因此在每次反向傳播前需要清零梯度（optimizer.zero_grad() 或 tensor.grad.zero_()）。
* 無梯度：如果某個張量未設置 requires_grad=True，或者未參與損失計算，則其 .grad 為 None。