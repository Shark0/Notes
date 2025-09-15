# Deploy and Troubleshoot a Website

## Challenge scenario
Your company is ready to launch a brand new product! Because you are entering a totally new space, you have decided to deploy a new website as part of the product launch. The new site is complete, but the person who built the new site left the company before they could deploy it.

### Your challenge
Your challenge is to deploy the site in the public cloud by completing the tasks below. You will use a simple Apache web server as a placeholder for the new site in this exercise. Good luck!

### Running a basic Apache web server
A virtual machine instance on Compute Engine can be controlled like any standard Linux server. Deploy a simple Apache web server (a placeholder for the new product site) to learn the basics of running a server on a virtual machine instance.

## Task 1. Create a Linux VM instance
* Create a Linux virtual machine, name it Instance name and specify the zone as Compute zone.

---
### **Console 作法**
1.  在 Google Cloud Console 中，前往 **導覽選單** > **Compute Engine** > **VM 執行個體**。
2.  點擊 **建立執行個體**。
3.  **名稱**：輸入您想要的執行個體名稱 (例如 `my-instance`)。
4.  **地區** 和 **區域**：選擇您要使用的地區和區域 (例如 `us-central1` 和 `us-central1-a`)。
5.  **開機磁碟**：保留預設的 Debian GNU/Linux 映像檔，或點擊 **變更** 來選擇其他作業系統。
6.  點擊 **建立**。

### **Cloud Shell 作法**
```bash
# 請將 [INSTANCE_NAME] 和 [ZONE] 替換為您自己的設定
gcloud compute instances create [INSTANCE_NAME] --zone=[ZONE] --image-family=debian-11 --image-project=debian-cloud
```
*範例:*
```bash
gcloud compute instances create my-instance --zone=us-central1-a --image-family=debian-11 --image-project=debian-cloud
```
---

## Task 2. Enable public access to VM instance
* While creating the Linux instance, make sure to apply the appropriate firewall rules so that potential customers can find your new product.

---
### **Console 作法**
*在建立 VM 的過程中：*
1.  在 **防火牆** 區塊，勾選 **允許 HTTP 流量**。
2.  (選用) 勾選 **允許 HTTPS 流量**。
3.  點擊 **建立**。

*如果 VM 已建立：*
1.  前往 **VPC 網路** > **防火牆** 頁面，點擊 **建立防火牆規則**。
2.  **名稱**: `allow-http`
3.  **目標標記**: `http-server` (您需要將此標記新增到您的 VM)
4.  **來源 IP 範圍**: `0.0.0.0/0`
5.  **通訊協定和通訊埠**: 勾選 **指定的通訊協定和通訊埠**，然後輸入 `tcp:80`。
6.  點擊 **建立**。
7.  前往您的 VM 執行個體詳細資料頁面，點擊 **編輯**，並在 **網路標記** 欄位中新增 `http-server`。

### **Cloud Shell 作法**
*建議在建立 VM 時直接允許 HTTP 流量，這會自動套用正確的規則與標籤：*
```bash
gcloud compute instances create [INSTANCE_NAME] --zone=[ZONE] --tags=http-server --metadata=startup-script='#! /bin/bash
  sudo apt-get update
  sudo apt-get install -y apache2
  echo "<!doctype html><html><body><h1>Hello World!</h1></body></html>" | sudo tee /var/www/html/index.html'
```
*或者，手動建立防火牆規則並將標籤套用到現有 VM：*
```bash
# 建立允許 HTTP 流量的規則
gcloud compute firewall-rules create allow-http --allow tcp:80 --source-ranges 0.0.0.0/0 --target-tags=http-server

# 將標籤新增到您的 VM
gcloud compute instances add-tags [INSTANCE_NAME] --zone=[ZONE] --tags=http-server
```
---

## Task 3. Running a basic Apache Web Server
A virtual machine instance on Compute Engine can be controlled like any standard Linux server.

* Deploy a simple Apache web server (a placeholder for the new product site) to learn the basics of running a server on a virtual machine instance.

---
### **Console 作法**
1.  在 **VM 執行個體** 頁面，找到您的 VM，然後點擊 **SSH** 按鈕。
2.  在新開啟的終端機視窗中，執行以下指令來安裝 Apache 並建立網頁：
    ```bash
    # 更新套件管理員
    sudo apt-get update

    # 安裝 Apache2
    sudo apt-get install -y apache2

    # 建立一個簡單的 "Hello World" 網頁
    echo '<!doctype html><html><body><h1>Hello World!</h1></body></html>' | sudo tee /var/www/html/index.html
    ```

### **Cloud Shell 作法**
1.  使用 `gcloud` 透過 SSH 連線到您的 VM：
    ```bash
    gcloud compute ssh [INSTANCE_NAME] --zone=[ZONE]
    ```
2.  連線後，執行與 Console 作法相同的指令來安裝 Apache。
    ```bash
    sudo apt-get update
    sudo apt-get install -y apache2
    echo '<!doctype html><html><body><h1>Hello World!</h1></body></html>' | sudo tee /var/www/html/index.html
    ```
---

## Task 4. Test your server
* Test that your instance is serving traffic on its external IP.
You should see the "Hello World!" page (a placeholder for the new product site).

---
### **Console 作法**
1.  前往 **VM 執行個體** 頁面。
2.  在您的 VM 執行個體列表中，找到 **外部 IP** 這一欄的 IP 位址。
3.  點擊該 IP 位址 (或複製並貼到瀏覽器網址列)，您的瀏覽器應該會顯示 "Hello World!" 頁面。

### **Cloud Shell 作法**
1.  執行以下指令來取得您 VM 的外部 IP 位址：
    ```bash
    gcloud compute instances describe [INSTANCE_NAME] --zone=[ZONE] --format='get(networkInterfaces[0].accessConfigs[0].natIP)'
    ```
2.  複製指令所輸出的 IP 位址。
3.  在您的網頁瀏覽器中開啟 `http://[複製的 IP 位址]`，您應該會看到 "Hello World!" 的頁面。
---
