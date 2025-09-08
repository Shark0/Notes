# Task 1. Create a storage bucket
沒甚麼好筆記的

# Task 2. Create a VM instance with a remote startup script
## 方法一 使用 gcloud 指令行工具 (CLI)
這是自動化和腳本化作業最常用的方法。你需要在 gcloud compute instances create 指令中，使用 --metadata-from-file 參數來指定啟動腳本的路徑。

Bash
```
gcloud compute instances create [你的 VM 實例名稱] \
--project=[你的專案 ID] \
--zone=[你的區域] \
--image-family=[你選擇的作業系統] \
--image-project=[作業系統專案，如 debian-cloud] \
--scopes=https://www.googleapis.com/auth/cloud-platform \
--metadata=startup-script-url=gs://[你的 bucket 名稱]/[你的腳本檔案名稱]
```
指令說明：
* --scopes=https://www.googleapis.com/auth/cloud-platform: 這是非常重要的一步！這個參數會賦予你的 VM 足夠的權限來存取 Cloud Storage。如果沒有這個權限，VM 將無法下載你的腳本。
* --metadata=startup-script-url=gs://[你的 bucket 名稱]/[你的腳本檔案名稱]: 這就是關鍵所在。它告訴 GCP 在 VM 啟動時，去指定的 GCS URL 下載並執行腳本。gs:// 前綴是 Cloud Storage 資源的標準格式。

## 方法二 使用 Google Cloud Console (網頁介面)
如果你喜歡使用網頁介面，也可以在建立 VM 時設定這個選項。

* 登入 Google Cloud Console。
* 導覽至 Compute Engine > VM 實例，然後點擊「建立實例」。
* 在建立頁面上，展開「進階選項」，然後點擊「管理、安全性、磁碟、網路、單一承租者節點」。
* 找到「中繼資料」(Metadata) 區塊，在欄位中新增一個鍵值對：
  * 鍵 (Key)：startup-script-url
  * 值 (Value)：gs://[你的 bucket 名稱]/[你的腳本檔案名稱]
* 完成以上設定後，點擊「建立」，新的 VM 實例啟動時就會自動執行你放在 Cloud Storage 中的腳本了。

# Task 3. Create a firewall rule to allow traffic (80/tcp)
## 方法一：使用 gcloud 指令
這是最快速且適合自動化的方法。你只需要執行以下指令，就能建立一條名為 allow-http 的防火牆規則。

Bash
```
gcloud compute firewall-rules create allow-http \
--network=default \
--action=ALLOW \
--direction=INGRESS \
--rules=tcp:80 \
--source-ranges=0.0.0.0/0 \
--target-tags=http-server \
--description="Allow incoming HTTP traffic on port 80"
```
指令說明：
* --network=default: 你的 VM 通常會位於 default 網路中。
* --action=ALLOW: 允許符合規則的流量。
* --direction=INGRESS: 指的是進入你的 VM 的流量。
* --rules=tcp:80: 這是核心設定，指定允許 TCP 協定的 80 port 流量。
* --source-ranges=0.0.0.0/0: 允許來自任何 IP 地址的流量。
* --target-tags=http-server: 這是最重要的一個參數！它會將這條防火牆規則套用到所有帶有 http-server 網路標籤 (tag) 的 VM 上。

步驟：
* 執行上面的 gcloud 指令，建立防火牆規則。
* 將你的 VM 設定標籤：前往你的 VM 實例，編輯其網路設定，在「網路標籤」(Network tags) 欄位中，新增 http-server 這個標籤。

## 方法二：使用 Google Cloud Console (網頁介面)
* 在 Google Cloud Console 中，導覽至 VPC 網路 (VPC network) > 防火牆 (Firewall)。
* 點擊頁面頂部的「建立防火牆規則 (CREATE FIREWALL RULE)」。
* 填寫規則細節：
* 名稱 (Name)：輸入一個好記的名稱，例如 allow-http-80。
* 網路 (Network)：選擇你的 VM 所在的網路，通常是 default。
* 流量方向 (Direction of traffic)：選擇 Ingress (進入)。
* 目標 (Target)：選擇 指定的目標標籤 (Specified target tags)。
* 目標標籤 (Target tags)：輸入 http-server。
* 來源篩選器 (Source filter)：選擇 IP 位址範圍 (IP ranges)。
* 來源 IP 位址範圍 (Source IP ranges)：輸入 0.0.0.0/0 (代表所有 IP)。
* 通訊協定和通訊埠 (Protocols and ports)：選擇「指定的通訊協定與通訊埠 (Specified protocols and ports)」，然後勾選「tcp」並在旁邊的欄位輸入 80。
* 點擊「建立 (Create)」。
* 將標籤新增到你的 VM：回到你的 VM 實例，點擊「編輯」，在「網路標籤 (Network tags)」欄位中，新增 http-server 這個標籤。


# Task 4. Test that the VM is serving web content
* 打開Instance頁面，看Instance對外部的IP
* 在瀏覽器輸入 http://${instance_ip}
