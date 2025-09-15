# Task 1. Create a Kubernetes cluster
* Your test environment is limited in capacity, so you should limit the test Kubernetes cluster you are creating to just two e2-standard-2 instances. You must call your cluster echo-cluster.


### Cloud Shell 作法
```bash
gcloud container clusters create echo-cluster --num-nodes=2 --machine-type=e2-standard-2
```

### Console 作法
1.  在 GCP Console 中，導覽至 **Kubernetes Engine** > **叢集 (Clusters)**。
2.  點擊 **建立 (Create)**。
3.  **叢集名稱 (Cluster name)** 輸入 `echo-cluster`。
4.  在左側導覽面板中，點擊 **節點集區 (Node pools)** > **default-pool**。
5.  將 **節點數量 (Number of nodes)** 設定為 `2`。
6.  在 **節點 (Nodes)** 下方，將 **機器類型 (Machine type)** 變更為 `e2-standard-2`。
7.  點擊 **建立 (Create)**。


# Task 2. Build a tagged Docker image
The sample application, including the Dockerfile and the application context files, are contained in an archive called echo-web.tar.gz. The archive has been copied to a Cloud Storage bucket belonging to your lab project called gs://[PROJECT_ID].
* You must deploy this with a tag called v1.


### Cloud Shell 作法
1.  從 Cloud Storage 下載原始碼壓縮檔 (請將 `[PROJECT_ID]` 替換為您的專案 ID):
    ```bash
    gsutil cp gs://[PROJECT_ID]/echo-web.tar.gz .
    ```
2.  解壓縮檔案：
    ```bash
    tar -xvzf echo-web.tar.gz
    ```
3.  進入原始碼目錄：
    ```bash
    cd echo-web
    ```
4.  使用 v1 標籤建置 Docker 映像檔 (請將 `[PROJECT_ID]` 替換為您的專案 ID)：
    ```bash
    docker build -t gcr.io/[PROJECT_ID]/echo-web:v1 .
    ```

### Console 作法
使用圖形化介面直接建置 Docker 映像檔的標準方法是透過 Cloud Build。但針對這個 Lab，最直接的方式是使用 Cloud Shell。

如果您想使用 Cloud Build，大致步驟如下：
1.  將 `echo-web.tar.gz` 的內容上傳到 Cloud Source Repositories。
2.  在 Cloud Build 中建立一個觸發條件，當程式碼推送到存放區時，自動從 Dockerfile 建置映像檔。


# Task 3. Push the image to the Google Container Registry
* Your organization has decided that it will always use the gcr.io Container Registry hostname for all projects. The sample application is a simple web application that reports some data describing the configuration of the system where the application is running. It is configured to use TCP port 8000 by default.


### Cloud Shell 作法
1.  (如果尚未設定) 授權 Docker 可以推送到 GCR：
    ```bash
    gcloud auth configure-docker
    ```
2.  推送您剛才建立的映像檔 (請將 `[PROJECT_ID]` 替換為您的專案 ID)：
    ```bash
    docker push gcr.io/[PROJECT_ID]/echo-web:v1
    ```

### Console 作法
這個步驟主要是透過指令列完成的。推送完成後，您可以在 Console 中進行驗證：
1.  導覽至 **Container Registry** > **映像檔 (Images)**。
2.  您應該會看到名為 `echo-web` 的映像檔，其標籤為 `v1`。


# Task 4. Deploy the application to the Kubernetes cluster
* Even though the application is configured to respond to HTTP requests on port 8000, you must configure the service to respond to normal web requests on port 80. When configuring the cluster for your sample application, call your deployment echo-web.


### Cloud Shell 作法
1.  建立一個名為 `echo-web` 的 deployment，並使用您剛才推送的映像檔 (請將 `[PROJECT_ID]` 替換為您的專案 ID)：
    ```bash
    kubectl create deployment echo-web --image=gcr.io/[PROJECT_ID]/echo-web:v1
    ```
2.  將 deployment 公開為一個服務，讓外部可以透過 Port 80 存取，並將流量導向容器的 Port 8000：
    ```bash
    kubectl expose deployment echo-web --type=LoadBalancer --port=80 --target-port=8000
    ```

### Console 作法
1.  在 GCP Console 中，導覽至 **Kubernetes Engine** > **工作負載 (Workloads)**。
2.  點擊 **部署 (Deploy)**。
3.  在 **容器映像檔 (Container image)** 欄位，選擇您剛才推送的映像檔 (`gcr.io/[PROJECT_ID]/echo-web:v1`)。
4.  將 **應用程式名稱 (Application name)** 設定為 `echo-web`。
5.  確認 **叢集 (Cluster)** 已選擇 `echo-cluster`。
6.  點擊 **部署 (Deploy)**。
7.  部署完成後，導覽至 **Kubernetes Engine** > **服務與輸入 (Services & Ingress)**。
8.  找到 `echo-web` 服務並點擊它，或點擊 **公開 (Expose)** 並選擇 `echo-web` deployment。
9.  設定服務：
    *   **通訊埠 (Port)**: `80`
    *   **目標通訊埠 (Target port)**: `8000`
    *   **服務類型 (Service type)**: `負載平衡器 (LoadBalancer)`
10. 點擊 **公開 (Expose)**。

