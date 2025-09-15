# Task 1. Create the VPC network

### 【GCP Cloud Shell 作法】

1.  **建立自訂模式的 VPC 網路 `securenetwork`：**
    ```bash
    gcloud compute networks create securenetwork --subnet-mode=custom
    ```

2.  **在 `securenetwork` 中建立子網路：**
    (請將 `[REGION]` 替換成您要使用的地區，例如 `us-central1`)
    ```bash
    gcloud compute networks subnets create secure-subnet \
        --network=securenetwork \
        --range=10.130.0.0/20 \
        --region=[REGION]
    ```

3.  **建立防火牆規則，允許從任何來源 (0.0.0.0/0) 透過 RDP (TCP port 3389) 連線到帶有 `rdp-bastion` 標籤的 VM：**
    ```bash
    gcloud compute firewall-rules create allow-rdp-bastion \
        --network=securenetwork \
        --allow=tcp:3389 \
        --source-ranges=0.0.0.0/0 \
        --target-tags=rdp-bastion
    ```

### 【GCP Console 作法】

1.  **建立 VPC 網路：**
    *   前往 GCP Console > **VPC network** > **VPC networks**。
    *   點擊 **CREATE VPC NETWORK**。
    *   **Name**: 輸入 `securenetwork`。
    *   **Subnet creation mode**: 選擇 **Custom**。
    *   點擊 **CREATE**。

2.  **建立子網路：**
    *   在 `securenetwork` 建立後，點擊 **ADD SUBNET**。
    *   **Name**: 輸入 `secure-subnet`。
    *   **Region**: 選擇您要的地區 (例如 `us-central1`)。
    *   **IP address range**: 輸入 `10.130.0.0/20`。
    *   點擊 **ADD**。

3.  **建立防火牆規則：**
    *   前往 GCP Console > **VPC network** > **Firewall**。
    *   點擊 **CREATE FIREWALL RULE**。
    *   **Name**: 輸入 `allow-rdp-bastion`。
    *   **Network**: 選擇 `securenetwork`。
    *   **Targets**: 選擇 **Specified target tags**。
    *   **Target tags**: 輸入 `rdp-bastion`。
    *   **Source filter**: 選擇 **IPv4 ranges**。
    *   **Source IPv4 ranges**: 輸入 `0.0.0.0/0`。
    *   **Protocols and ports**: 選擇 **Specified protocols and ports**，勾選 **TCP** 並輸入 `3389`。
    *   點擊 **CREATE**。

---
# Task 2. Deploy your Windows instances and configure user passwords

### 【GCP Cloud Shell 作法】

(請將 `[ZONE]` 替換成您要使用的可用區，例如 `us-central1-a`)

1.  **部署安全主機 `vm-securehost`：**
    ```bash
    gcloud compute instances create vm-securehost \
        --zone=[ZONE] \
        --machine-type=n1-standard-2 \
        --image-project=windows-cloud \
        --image-family=windows-2016 \
        --network-interface="network=securenetwork,subnet=secure-subnet,no-address" \
        --network-interface="network=default,no-address"
    ```

2.  **部署堡壘主機 `vm-bastionhost`：**
    ```bash
    gcloud compute instances create vm-bastionhost \
        --zone=[ZONE] \
        --machine-type=n1-standard-2 \
        --image-project=windows-cloud \
        --image-family=windows-2016 \
        --network-interface="network=securenetwork,subnet=secure-subnet" \
        --network-interface="network=default,no-address" \
        --tags=rdp-bastion
    ```

3.  **為兩台 VM 設定 Windows 使用者密碼：**
    (請將 `[USERNAME]` 替換成您要設定的使用者名稱)
    ```bash
    # 為 vm-securehost 設定密碼
    gcloud compute reset-windows-password vm-securehost --zone=[ZONE] --user=[USERNAME]

    # 為 vm-bastionhost 設定密碼
    gcloud compute reset-windows-password vm-bastionhost --zone=[ZONE] --user=[USERNAME]
    ```
    *注意：執行此指令後，gcloud 會顯示一組臨時密碼，請務必將其複製並妥善保存。*

### 【GCP Console 作法】

1.  **部署安全主機 `vm-securehost`：**
    *   前往 GCP Console > **Compute Engine** > **VM instances** > **CREATE INSTANCE**。
    *   **Name**: `vm-securehost`。
    *   **Boot disk**: 選擇 **Windows Server 2016 Datacenter**。
    *   展開 **Advanced options** > **Networking** > **Network interfaces**：
        *   **nic0**: Network: `securenetwork`, Subnetwork: `secure-subnet`, External IPv4 address: **None**。
        *   **ADD NETWORK INTERFACE** > **nic1**: Network: `default`, External IPv4 address: **None**。
    *   點擊 **CREATE**。

2.  **部署堡壘主機 `vm-bastionhost`：**
    *   再次點擊 **CREATE INSTANCE**。
    *   **Name**: `vm-bastionhost`。
    *   **Boot disk**: 選擇 **Windows Server 2016**。
    *   **Networking tags**: 輸入 `rdp-bastion`。
    *   展開 **Advanced options** > **Networking** > **Network interfaces**：
        *   **nic0**: Network: `securenetwork`, Subnetwork: `secure-subnet`, External IPv4 address: **Ephemeral**。
        *   **ADD NETWORK INTERFACE** > **nic1**: Network: `default`, External IPv4 address: **None**。
    *   點擊 **CREATE**。

3.  **為兩台 VM 設定 Windows 使用者密碼：**
    *   在 VM instances 列表中，找到 VM 並點擊進入詳情頁。
    *   點擊 **SET WINDOWS PASSWORD**，輸入使用者名稱後點擊 **SET**。
    *   系統會顯示臨時密碼，請複製下來。對另一台 VM 重複此步驟。

---
# Task 3. Connect to the secure host and configure Internet Information Server

### 【作法說明】

這個任務主要是在 Windows 環境中操作，因此沒有對應的 gcloud 指令。以下是圖形化介面的操作流程：

1.  **從您的本機電腦 RDP 到堡壘主機 `vm-bastionhost`：**
    *   在 GCP Console 的 VM instances 列表頁面，找到 `vm-bastionhost`。
    *   在 **Connect** 欄位，點擊 **RDP** 按鈕旁的下拉選單，選擇 **Download the RDP file**。
    *   使用您電腦上的遠端桌面用戶端軟體，開啟這個 `.rdp` 檔案。
    *   在登入提示中，輸入您為 `vm-bastionhost` 設定的使用者名稱和密碼。

2.  **從堡壘主機 `vm-bastionhost` RDP 到安全主機 `vm-securehost`：**
    *   成功登入 `vm-bastionhost` 後，在 Windows 桌面中，點擊 **Start** (開始) 選單。
    *   搜尋並執行 `mstsc.exe` 或 "Remote Desktop Connection"。
    *   在 **Computer** (電腦) 欄位，輸入 `vm-securehost` 的內部 IP 位址 (例如 `10.130.0.2`)。您可以在 GCP Console 的 `vm-securehost` 詳情頁找到這個 IP。
    *   點擊 **Connect**，然後輸入您為 `vm-securehost` 設定的使用者名稱和密碼。

3.  **在 `vm-securehost` 上安裝 IIS (Internet Information Server)：**
    *   成功登入 `vm-securehost` 後，系統通常會自動開啟 **Server Manager** (伺服器管理員)。
    *   在 Server Manager 儀表板中，點擊 **Add roles and features** (新增角色及功能)。
    *   在精靈引導中，持續點擊 **Next** 直到 **Server Roles** (伺服器角色) 頁面。
    *   勾選 **Web Server (IIS)**。如果跳出提示，請點擊 **Add Features** (新增功能)。
    *   繼續點擊 **Next**，最後點擊 **Install** (安裝)。
    *   等待安裝完成即可。