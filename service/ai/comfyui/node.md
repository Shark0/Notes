# Node

## Default
### CLIPLoader
載入 CLIP 模型，用於文字到 embedding 的轉換。

### CLIPTextEncode
將文字 prompt 編碼成 conditioning 訊號，引導生成。

### CLIPVisionEncode
將 CLIP Vision 模型編碼圖像，提供視覺條件給後續節點（如 WanImageToVideo）。

### ImageResizeKJv2
調整圖像尺寸，使用 lanczos 方法，保持比例。

### ImageScaleBy
按比例縮放圖像，用於最終幀上採樣。

### KSamplerAdvanced
先進 KSampler：執行去噪採樣。第一個用於高噪聲階段（steps=8, CFG=1），第二個用於低噪聲階段（steps=8, CFG=1）。使用 euler_ancestral 採樣器。

### LoadImage
載入起始圖像，作為輸入幀。

### LoraLoaderModelOnly
只加載 LoRA 到模型（不影響 CLIP），用於細調動畫效果

### ModelSamplingSD3
為SD3模型設定採樣移位，用於高/低噪聲階段的模型調整。

### PrimitiveBoolean
布林值輸入，用於切換 A/B 路徑

### PrimitiveFloat
浮點數輸入。


### PrimitiveStringMultiline
多行文字輸入，用於正面提示。

### Reroute
重新路由連接，用於簡化佈線。

### StringConcatenate
連接兩個字串（提示 + 額外文字），用於組合提示。

### SaveImage
存圖片

### UNETLoader
載入標準UNet模型。

### WanImageToVideo
從起始圖像生成視頻潛在空間，輸入 positive/negative 條件、VAE、CLIP Vision 和尺寸參數。輸出條件和 latent 用於採樣。

### VAEDecode
將latent解碼成可視化圖像輸出，用於生成後的後處理。

### VAELoader
載入 VAE模型，用於 latent 空間與圖像間的編碼/解碼轉換。

## Custom
### AudioCombine
合併兩個音頻軌道

ComfyUI Manager 搜尋 "audio-separation-nodes-comfyui" 安裝

### CR Prompt Text
提示文字輸入器，用於 bikini girl 動畫描述。

ComfyUI Manager 搜尋 "ComfyUI-Impact-Pack" 安裝（包含 CR 系列），或 GitHub: https://github.com/ltdrdata/ComfyUI-Impact-Pack
### Easy Ab
A/B 切換器，基於布林值選擇輸入路徑（用於音頻合成分支）。

ComfyUI Manager 搜尋 "comfyui-easy-use" 安裝。

### Easy CleanGpuUsed
清理 GPU 記憶體，防止記憶體溢出。用於節點間過渡。

ComfyUI Manager 搜尋 "comfyui-easy-use" 安裝，或 https://www.runcomfy.com/comfyui-nodes/ComfyUI-Easy-Use/easy-cleanGpuUsed

### Easy ShowAnything
顯示任意輸入

ComfyUI Manager 搜尋 "comfyui-easy-use" 安裝。

### GetNode
從節點獲取屬性

ComfyUI Manager 搜尋 "ComfyUI-Impact-Pack" 安裝。

### HunyuanVideoFoley
使用 Hunyuan 模型為視頻幀生成音頻（foley 效果）。

ComfyUI Manager 搜尋 "HunyuanVideoFoley" 或相關插件安裝，或 https://www.hunyuanvideofoley.org/

### ImpactSwitch
切換輸入值

ComfyUI Manager 搜尋 "ComfyUI-Impact-Pack" 安裝。

### JWInteger
整數輸入。

https://www.runcomfy.com/comfyui-nodes/comfyui-various/JWInteger

### Pick From Batch (mtb)
從圖像批次中挑選特定幀（從末尾挑 1 張），用於提取最後一幀。

ComfyUI Manager 搜尋 "comfy-mtb" 安裝，或 GitHub: https://github.com/mattwiller/ComfyUI-MTB

### SaveAudio
保存合併音頻到 audio/ComfyUI 資料夾。

### Seed (rgthree)
進階種子生成器（隨機化），用於噪聲種子。

ComfyUI Manager 搜尋 "rgthree-comfy" 安裝，或 GitHub: https://github.com/rgthree/rgthree-comfy

### SetNode
設定節點屬性

ComfyUI Manager 搜尋 "ComfyUI-Impact-Pack" 安裝。

### SimpleMath+
簡單數學運算（a*b+1），用於計算幀數 (length = time * fps + 1)。

ComfyUI Manager 搜尋 "ComfyUI-Impact-Pack" 安裝。

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

