# 🗓 6 週 AWS SAA 準備計劃表

## 📍 週 1：核心服務打底

* **學習重點**

    * AWS Global Infrastructure（Region / AZ / Edge）
    * EC2：Instance 類型、AMI、EBS、Load Balancer、Auto Scaling
    * IAM：User、Role、Policy、MFA
* **實作**

    * 建立 Free Tier 帳號
    * 啟動一台 EC2，連線 SSH，掛上 EBS，設定安全組
* **資源**

    * 官方：[Global Infrastructure](https://aws.amazon.com/about-aws/global-infrastructure/)
    * Udemy/A Cloud Guru：EC2 + IAM 模組
* **目標**：能解釋 EC2、IAM 的核心概念，做基本操作。

---

## 📍 週 2：儲存與資料庫

* **學習重點**

    * S3：存儲類型、Lifecycle Policy、Versioning、加密
    * Glacier：冷存儲
    * RDS：多 AZ、Read Replica、Aurora
    * DynamoDB：分區、RCU/WCU、Global Table
* **實作**

    * 建立 S3 Bucket，測試版本控制、加密、Lifecycle
    * 建立 RDS MySQL，測試備份與高可用
* **目標**：能比較不同儲存/資料庫方案，知道什麼情境該用什麼。

---

## 📍 週 3：網路與安全

* **學習重點**

    * VPC：Subnet、Route Table、Internet Gateway、NAT
    * Security Group vs NACL
    * Route 53：DNS、加權路由、健康檢查
    * CloudFront：CDN、快取
* **實作**

    * 建立一個 VPC，設定公有子網+私有子網
    * 部署 EC2 + RDS 在不同子網，用 NAT 讓私有子網連外
* **目標**：能畫出基本三層 VPC 架構圖並解釋。

---

## 📍 週 4：Serverless 與應用服務

* **學習重點**

    * Lambda + API Gateway
    * SQS、SNS、EventBridge
    * Step Functions（簡單流程）
    * Elastic Beanstalk、ECS/EKS（基礎概念）
* **實作**

    * 用 Lambda + API Gateway 建立一個簡單 API
    * 測試 SQS 佇列 + SNS 訂閱
* **目標**：熟悉 event-driven 架構與 Serverless 模式。

---

## 📍 週 5：綜合架構與最佳實踐

* **學習重點**

    * Well-Architected Framework（5 大支柱：Operational, Security, Reliability, Performance, Cost）
    * Cost Explorer / Trusted Advisor
    * CloudFormation / IaC（基本概念）
* **實作**

    * 用 CloudFormation 建立 S3 + EC2 環境
    * 使用 Cost Explorer 分析帳單
* **練習**

    * 做至少 100 題練習題（Whizlabs / Tutorials Dojo）
* **目標**：能針對情境題選出「高可用 + 成本最佳」方案。

---

## 📍 週 6：模擬考與衝刺

* **學習重點**

    * 針對錯誤題回顧服務限制與最佳實踐
    * 確認自己對每個核心服務至少有 1–2 個清楚案例
* **練習**

    * 做 2–3 次完整模擬考（65 題，130 分鐘）
    * 每次考完分析錯題，整理錯誤筆記
* **目標**

    * 模擬考達到 **70–80% 正確率**
    * 知道自己對每類題型的答題策略（高可用、成本、效能、安全）

* https://skillbuilder.aws/category/role/solutions-architect