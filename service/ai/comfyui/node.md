# Node

## Default
### CLIPLoader
載入 CLIP 模型（這裡用 umt5_xxl），用於文字到 embedding 的轉換，支援 WAN 的 "wan" 類型。

### CLIPTextEncode
將文字 prompt 編碼成 conditioning 訊號（positive: 描述動作如 "lifts her tshirt shows her boobs"），引導生成。

### LoadImage
載入起始圖像（這裡為特定 PNG 檔案），作為 I2V 的輸入幀。

### UNETLoader
載入標準 UNet 模型（.safetensors 格式），備用或與 GGUF 並用（這裡未連線，可能是備份）。

### VAEDecode
將 latent (潛在空間) 解碼成可視化圖像輸出，用於生成後的後處理。

### VAELoader
載入 VAE (Variational Autoencoder) 模型，用於 latent 空間與圖像間的編碼/解碼轉換。

## Custom
### UnetLoaderGGUF
載入 GGUF 量化 UNet 模型（低 VRAM 版本），作為 diffusion 模型的核心，用於去噪與生成。

### Video Combine Node
把 WAN2.2 I2V 生成的 16~24 張圖 → 變成 可播放的 MP4 影片，支援 音訊、迴圈、批次輸出

| 參數              | 功能說明                             |
|-----------------|----------------------------------|
| images          | 輸入一疊圖片（通常是 WAN2Video 輸出的 frames） | 
| frame_rate      | 影片 FPS（你設 21 → 很流暢）              |
| loop_count      | 影片重播次數（0 = 無限）                   |
| filename_prefix | 輸出檔名前綴（你設 AnimateDiff）           |  
| format          | 輸出格式（video/h264-mp4 = 標準 MP4）    |    
| pix_fmt         | 色彩格式（yuv420p = 相容性最好）            |          
| crf             | 畫質壓縮（19 = 高畫質，低數字 = 檔大）          |             
| save_metadata   | 儲存 prompt 等資訊到檔案                 |
| save_output     | true → 真的輸出影片                    |               

### Video_Upscale_With_Model
使用 ESRGAN/Real-ESRGAN 等模型對影片幀進行升級，提升解析度與細節。

### VHS_VideoCombine
合併多張圖像幀成影片（MP4），支援 FPS、迴圈、CRF 壓縮（這裡未指定完整參數，但從類型推斷為 VHS 版本

### WanImageToVideo
WAN 專用 I2V 生成核心節點：輸入起始圖像、positive/negative prompt、VAE，輸出條件化與 latent 影片幀。 處理圖像到影片的轉換，包括動作序列。

