# Model

## Checkpoints
### wan2.2-t2v-rapid-aio-v10-nsfw.safetensors
* text to video

## Clip
### umt5_xxl_fp8_e4m3fn_scaled.safetensors
CLIP (文字編碼器),"UMT5-XXL FP8 量化 CLIP，用於 WAN 的文字到 embedding 轉換，支援長 prompt 與 NSFW 描述（如 ""cinematic realistic style""）。
下載自 Hugging Face: comfyanonymous/flux_text_encoders 或 WAN repo。放置：ComfyUI/models/clip/。大小 ~5GB。

## UNET
### wan2.2-1b-rapid-aio-v10-nsfw-Q2_K.gguf
* Image-to-Video
* https://huggingface.co/befox/WAN2.2-14B-Rapid-AllInOne-GGUF/tree/main/v10

### rapidWAN22I2VGGUF_q4KMRapidV10.gguf
WAN 2.2 I2V 核心模型（Q4_K_M 量化，低 VRAM ~8-12GB），處理圖像到 125 幀影片的 diffusion 生成，支援動作如lifts tshirt。
下載自 Hugging Face: befox/WAN2.2-14B-Rapid-AllInOne-GGUF（選 Q4_K_M）。放置：ComfyUI/models/unet/。大小 ~7-10GB。

### wan2.2-i2v-rapid-aio.safetensors
UNet (AIO 全模型),WAN 2.2 I2V All-In-One 版本（包含 UNet + 整合邏輯），備用高品質生成（未連線，可能作為 fallback）。
下載自 Hugging Face: Phr00t/WAN2.2-14B-Rapid-AllInOne（wan2.2-i2v-rapid-aio-v10-nsfw.safetensors）。

## upscale_models
### 4x_foolhardy_Remacri.pth
Upscale (ESRGAN-like),4x 升級模型，用於影片幀 2x 放大（從 720p 到 ~1440p），專注細節恢復與銳利度。
下載自 Upscale repo: upscayl/upscayl 或 Hugging Face 搜尋 4x_foolhardy_Remacri。

## VAE
### wan_2.1_vae.safetensors
WAN 專用 VAE，用於高效 latent 編碼/解碼，減少生成 artifact，提升圖像品質
下載自 Hugging Face: Phr00t/WAN2.2-14B-Rapid-AllInOne（搜尋 VAE）。