# Migrate a MySQL Database to Google Cloud SQL

## Challenge scenario
Your WordPress blog is running on a server that is no longer suitable. As the first part of a complete migration exercise, you are migrating the locally hosted database used by the blog to Cloud SQL.

The existing WordPress installation is installed in the /var/www/html/wordpress directory in the instance called blog that is already running in the lab. You can access the blog by opening a web browser and pointing to the external IP address of the blog instance.

The existing database for the blog is provided by MySQL running on the same server. The existing MySQL database is called wordpress and the user called blogadmin with password Password1*, which provides full access to that database.

### Your challenge
* You need to create a new Cloud SQL instance to host the migrated database.
* Once you have created the new database and configured it, you can then create a database dump of the existing database and import it into Cloud SQL.
* When the data has been migrated, you will then reconfigure the blog software to use the migrated database.

* For this lab, the WordPress site configuration file is located here: /var/www/html/wordpress/wp-config.php.

To sum it all up, your challenge is to migrate the database to Cloud SQL and then reconfigure the application so that it no longer relies on the local MySQL database. Good luck!
```
Note: Your lab activity tracking score will initially report a score of 20 points because your blog is running. If you reconfigure the blog application to use Cloud SQL database successfully, those points will remain in your grand total.
If the database has been incorrectly migrated, the "blog is running" test will fail, reducing your score by 20 points.
```
```
Note: Use the following values for the zone and region where applicable Zone: ZONE Region: REGION
```

### Tips and tricks
Google Cloud SQL - How-To Guides: The Cloud SQL documentation includes a set of How-to guides that provide guidance on how to create instances and databases, and how to connect applications to those databases.

WordPress Installation and Migration: The WordPress Codex provides information on how to install, configure, and migrate WordPress sites. You will find the instructions on how to create and prepare databases for use with WordPress here.

## Task 1. Create a new Cloud SQL instance
In this task, you need to set up a new Cloud SQL instance in Google Cloud. Choose the right configurations and make sure to create the SQL instance in the Zone:ZONE and Region: REGION that will be suitable for hosting the WordPress database. Make sure you understand the requirements for the database to support the WordPress blog.


### Cloud Shell 作法

使用 `gcloud sql instances create` 指令建立一個新的 MySQL 執行個體。請將 `[INSTANCE_NAME]` 換成您自訂的名稱 (例如 `wordpress-db`)，並將 `[REGION]` 換成指定的區域。

```bash
gcloud sql instances create [INSTANCE_NAME] --database-version=MYSQL_8_0 --region=[REGION] --root-password="Password1*"
```

### Console 作法

1.  在 GCP Console 中，導覽至 **SQL**。
2.  點擊 **建立執行個體 (CREATE INSTANCE)**。
3.  選擇 **選擇 MySQL (Choose MySQL)**。
4.  輸入 **執行個體 ID (Instance ID)**，例如 `wordpress-db`。
5.  設定 `root` 使用者的密碼為 `Password1*`。
6.  在 **區域 (Region)** 和 **可用區 (Zone)** 下拉選單中，選擇指定的 `REGION` 和 `ZONE`。
7.  點擊 **建立執行個體 (CREATE INSTANCE)**。

## Task 2. Configure the new database
Once you've created the Cloud SQL instance, your next step is to configure the database within it. Set up the necessary database parameters, ensuring it's prepared to receive the existing WordPress database data.

### Cloud Shell 作法

1.  在 Cloud SQL 執行個體中建立名為 `wordpress` 的資料庫：
    ```bash
    gcloud sql databases create wordpress --instance=[INSTANCE_NAME]
    ```
2.  建立一個名為 `blogadmin` 的使用者，並設定密碼和存取權限：
    ```bash
    gcloud sql users create blogadmin --instance=[INSTANCE_NAME] --password="Password1*" --host=% 
    ```

### Console 作法

1.  在 SQL 執行個體清單中，點擊您剛建立的執行個體名稱。
2.  在左側導覽面板中，點擊 **資料庫 (Databases)**。
3.  點擊 **建立資料庫 (CREATE DATABASE)**，並將資料庫命名為 `wordpress`，然後點擊 **建立 (CREATE)**。
4.  在左側導覽面板中，點擊 **使用者 (Users)**。
5.  點擊 **建立使用者帳戶 (CREATE USER ACCOUNT)**。
6.  **使用者名稱 (User name)** 輸入 `blogadmin`。
7.  **密碼 (Password)** 輸入 `Password1*`。
8.  將 **主機名稱 (Host name)** 設定為 **允許任何主機 (%)**。
9.  點擊 **建立 (CREATE)**。

## Task 3. Perform a database dump and import the data
Your task here is to perform a dump of the existing wordpress MySQL database and then import this data into your newly created Cloud SQL database. This step is crucial in migrating the database effectively.


### Cloud Shell 作法

1.  透過 SSH 連線到 `blog` VM 執行個體：
    ```bash
    gcloud compute ssh blog --zone=[ZONE]
    ```
2.  在 VM 中，使用 `mysqldump` 匯出現有的 `wordpress` 資料庫：
    ```bash
    sudo mysqldump -u blogadmin -p'Password1*' wordpress > wordpress-backup.sql
    ```
3.  輸入 `exit` 離開 SSH 工作階段。
4.  建立一個 Cloud Storage 值區 (如果尚未建立)。請將 `[BUCKET_NAME]` 換成全域唯一的名稱。
    ```bash
    gsutil mb gs://[BUCKET_NAME]
    ```
5.  將 SQL 備份檔案從 VM 複製到您的 Cloud Shell 環境，然後再上傳到 Cloud Storage 值區：
    ```bash
    gcloud compute scp blog:~/wordpress-backup.sql . --zone=[ZONE]
    gsutil cp wordpress-backup.sql gs://[BUCKET_NAME]/
    ```
6.  將資料匯入到您的 Cloud SQL 執行個體：
    ```bash
    gcloud sql import sql [INSTANCE_NAME] gs://[BUCKET_NAME]/wordpress-backup.sql --database=wordpress
    ```

### Console 作法

1.  在 **VM 執行個體** 頁面，找到 `blog` 執行個體，並點擊 **SSH** 按鈕連線。
2.  在 VM 中，使用 `mysqldump` 匯出資料庫：
    ```bash
    sudo mysqldump -u blogadmin -p'Password1*' wordpress > wordpress-backup.sql
    ```
3.  在 SSH 視窗的右上角，點擊齒輪圖示，然後選擇 **下載檔案 (Download file)**，並輸入 `wordpress-backup.sql` 的完整路徑來下載它。
4.  導覽至 **Cloud Storage** > **值區 (Buckets)**，建立一個新的值區或使用現有的值區。
5.  將您剛下載的 `wordpress-backup.sql` 檔案上傳到值區中。
6.  導覽至 **SQL**，並點擊您的執行個體名稱。
7.  點擊 **匯入 (IMPORT)**。
8.  選擇您上傳的 SQL 檔案，並確認 **資料庫 (Database)** 為 `wordpress`。
9.  點擊 **匯入 (IMPORT)**。


## Task 4. Reconfigure the WordPress installation
Now that the database has been migrated to Cloud SQL, you need to reconfigure the WordPress software to use this new database. This involves editing the wp-config.php file in the WordPress directory to point to the Cloud SQL database, moving away from the local MySQL database.

### Cloud Shell 作法

1.  首先，取得 Cloud SQL 執行個體的 **私有 IP 位址 (Private IP address)**：
    ```bash
    gcloud sql instances describe [INSTANCE_NAME] --format='value(ipAddresses.filter(type=PRIVATE).ipAddress)'
    ```
2.  透過 SSH 連線到 `blog` VM 執行個體：
    ```bash
    gcloud compute ssh blog --zone=[ZONE]
    ```
3.  使用 `nano` 或 `vim` 編輯器修改 WordPress 設定檔：
    ```bash
    sudo nano /var/www/html/wordpress/wp-config.php
    ```
4.  找到 `define( 'DB_HOST', 'localhost' );` 這一行。
5.  將 `localhost` 替換為您在步驟 1 中取得的 Cloud SQL 私有 IP 位址。
6.  儲存並關閉檔案 (在 `nano` 中是 `Ctrl+X`，然後按 `Y` 和 `Enter`)。

### Console 作法

1.  在 **SQL** 執行個體頁面，點擊您的執行個體名稱。在 **總覽 (Overview)** 頁籤的 **連線 (Connect to this instance)** 區塊，找到並複製 **私有 IP 位址 (Private IP address)**。
2.  在 **VM 執行個體** 頁面，找到 `blog` 執行個體，並點擊 **SSH** 按鈕連線。
3.  使用 `nano` 或 `vim` 編輯器修改 WordPress 設定檔：
    ```bash
    sudo nano /var/www/html/wordpress/wp-config.php
    ```
4.  找到 `define( 'DB_HOST', 'localhost' );` 這一行。
5.  將 `localhost` 替換為您在步驟 1 中複製的 Cloud SQL 私有 IP 位址。
6.  儲存並關閉檔案。

## Task 5. Validate and troubleshoot
Your final task is to ensure that the WordPress blog is functioning correctly with the new Cloud SQL database. Check if the blog operates as expected and troubleshoot any issues you encounter. This step is important to confirm the success of your database migration and the overall functionality of the blog.

### Cloud Shell 作法

1.  取得 `blog` VM 的外部 IP 位址：
    ```bash
    gcloud compute instances describe blog --zone=[ZONE] --format='get(networkInterfaces[0].accessConfigs[0].natIP)'
    ```
2.  在您的本機瀏覽器中開啟 `http://[EXTERNAL_IP]/wordpress`，其中 `[EXTERNAL_IP]` 是上一個指令回傳的位址。
3.  確認 WordPress 網站能夠正常載入。

### Console 作法

1.  導覽至 **VM 執行個體** 頁面。
2.  在 `blog` 執行個體的資料列中，找到並複製 **外部 IP (External IP)** 位址。
3.  在您的瀏覽器中開啟一個新分頁，並瀏覽到 `http://[EXTERNAL_IP]/wordpress`。
4.  確認網站能夠正常顯示，並且文章和內容都和遷移前一樣。