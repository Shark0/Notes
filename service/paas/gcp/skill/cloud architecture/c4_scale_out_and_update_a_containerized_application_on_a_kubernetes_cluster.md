# Scale Out and Update a Containerized Application on a Kubernetes Cluster

## Challenge scenario
You are taking over ownership of a test environment and have been given an updated version of a containerized test application to deploy. Your systems' architecture team has started adopting a containerized microservice architecture. You are responsible for managing the containerized test web applications. You will first deploy the initial version of a test application, called echo-app to a Kubernetes cluster called echo-cluster in a deployment called echo-web. The cluster will be deployed in the ZONE zone.

* Before you get started, in the Navigation menu, select Cloud Storage > Buckets.
* Verify the echo-web-v2.tar.gz file is in the bucket name bucket.

Next, you will check to make sure your GKE cluster has been created before continuing.

*  In the Navigation menu, select Kubernetes Engine > Clusters.
Continue when you see a green checkmark next to echo-cluster

*  To deploy your first version of the application, run the following commands in Cloud Shell to get up and running:
```
gcloud container clusters get-credentials echo-cluster --zone=ZONE
```
```
kubectl create deployment echo-web --image=gcr.io/qwiklabs-resources/echo-app:v1
```
```
kubectl expose deployment echo-web --type=LoadBalancer --port 80 --target-port 8000
```

Your challenge
You need to update the running echo-app application in the echo-web deployment from the v1 to the v2 code you have been provided. You must also scale out the application to 2 instances and confirm that they are all running.

## Task 1. Build and deploy the updated application with a new tag
The updated sample application, including the Dockerfile and the application context files, are contained in an archive called echo-web-v2.tar.gz. The archive has been copied to a Cloud Storage bucket in your lab project called bucket name. V2 of the application adds a version number to the output of the application. In this task, you will download the archive, build the Docker image, and tag it with the v2 tag.

### Cloud Shell 作法
1.  從 Cloud Storage 下載原始碼壓縮檔 (請將 `[BUCKET_NAME]` 替換為您的值區名稱):
    ```bash
    gsutil cp gs://[BUCKET_NAME]/echo-web-v2.tar.gz .
    ```
2.  解壓縮檔案：
    ```bash
    tar -xvzf echo-web-v2.tar.gz
    ```
3.  進入原始碼目錄：
    ```bash
    cd echo-web
    ```
4.  使用 v2 標籤建置 Docker 映像檔 (請將 `[PROJECT_ID]` 替換為您的專案 ID)：
    ```bash
    docker build -t gcr.io/[PROJECT_ID]/echo-app:v2 .
    ```

### Console 作法
這個任務主要透過指令列完成。或者，您也可以使用 Cloud Build：
1.  將 `echo-web-v2.tar.gz` 的內容上傳到 Cloud Source Repositories。
2.  在 Cloud Build 中建立一個觸發條件，當程式碼被推送到存放區時，自動從 Dockerfile 建置映像檔。
3.  或是在 Cloud Build 主控台手動觸發一個建置，並指向您的原始碼。

## Task 2. Push the image to the Container Registry
Your organization uses the Container Registry to host Docker images for deployments, and uses the gcr.io Container Registry hostname for all projects. You must push the updated image to the Container Registry before deploying it.


### Cloud Shell 作法
1.  (如果尚未設定) 授權 Docker 可以推送到 GCR：
    ```bash
    gcloud auth configure-docker
    ```
2.  推送您剛才建立的 v2 映像檔 (請將 `[PROJECT_ID]` 替換為您的專案 ID)：
    ```bash
    docker push gcr.io/[PROJECT_ID]/echo-app:v2
    ```

### Console 作法
這個步驟主要是透過指令列完成的。推送完成後，您可以在 Console 中進行驗證：
1.  導覽至 **Container Registry** > **映像檔 (Images)**。
2.  您應該會看到名為 `echo-app` 的映像檔，其標籤為 `v2`。

## Task 3. Deploy the updated application to the Kubernetes cluster
In this task, you will deploy the updated application to the Kubernetes cluster. The deployment should be named echo-web and the application should be exposed on port 80. The application should be accessible from outside the cluster.

### Cloud Shell 作法
使用 `kubectl set image` 指令來觸發 deployment 的滾動更新 (rolling update)，將映像檔從 v1 更新為 v2 (請將 `[PROJECT_ID]` 替換為您的專案 ID)：

```bash
kubectl set image deployment/echo-web echo-app=gcr.io/[PROJECT_ID]/echo-app:v2
```

### Console 作法
1.  在 GCP Console 中，導覽至 **Kubernetes Engine** > **工作負載 (Workloads)**。
2.  找到並點擊 `echo-web` deployment。
3.  點擊上方的 **編輯 (EDIT)**。
4.  將 **容器映像檔 (Container image)** 的路徑從 `...:v1` 更新為 `...:v2`。
5.  點擊 **儲存 (SAVE)**。
6.  Kubernetes 將會自動執行滾動更新，用新版本的 Pod 取代舊版本的 Pod。

## Task 4. Scale out the application
In this task, you will need to scale out the application to 2 replicas.

### Cloud Shell 作法
使用 `kubectl scale` 指令將 deployment 的副本數量擴展到 2：

```bash
kubectl scale deployment echo-web --replicas=2
```

### Console 作法
1.  在 GCP Console 中，導覽至 **Kubernetes Engine** > **工作負載 (Workloads)**。
2.  找到 `echo-web` deployment。
3.  點擊該 deployment 右側的 **動作 (ACTIONS)** 選單 (三個點)。
4.  選擇 **擴縮 (Scale)**。
5.  將 **副本 (Replicas)** 數量設定為 `2`。
6.  點擊 **擴縮 (SCALE)** 按鈕。

## Task 5. Confirm the application is running
In this task, you will need to confirm that the application is running and responding correctly. You can use the external IP address of the application to test it.

### Cloud Shell 作法
1.  檢查 Pod 狀態，確認有 2 個 `echo-web` Pod 正在執行中：
    ```bash
    kubectl get pods
    ```
2.  取得服務的外部 IP 位址：
    ```bash
    kubectl get service echo-web
    ```
3.  使用 `curl` 指令搭配外部 IP 來測試應用程式。您應該會看到包含 `Version: 2.0` 的回應：
    ```bash
    curl http://[EXTERNAL_IP]
    ```
### Console 作法
1.  導覽至 **Kubernetes Engine** > **工作負載 (Workloads)**。
2.  點擊 `echo-web` deployment。在 **管理的 Pod (Managed pods)** 區塊，確認有 2 個 Pod 且狀態為 `執行中 (Running)`。
3.  導覽至 **Kubernetes Engine** > **服務與輸入 (Services & Ingress)**。
4.  找到 `echo-web` 服務。
5.  在 **端點 (Endpoints)** 欄位，點擊外部 IP 位址。這會在新的瀏覽器分頁中開啟應用程式，您應該會看到 v2 的頁面。

