# AWS

## Operational Excellence（卓越營運）
重點：可觀測性、自動化、變更管理、持續改善
* AWS CloudWatch
  * Metrics / Logs / Alarms 
  * 監控系統健康狀態、設定告警（SAA 常考）
* AWS CloudTrail
  * 記錄誰在什麼時間對 AWS 做了什麼操作 
  * 稽核、追蹤錯誤操作
* AWS Config
  * 資源設定是否符合規範（如 S3 是否公開）
  * 偵測 drift（偏離設定）
* AWS Systems Manager
  * 自動化維運（Patch、Run Command、Session Manager）
  * 不用 SSH 就能管 EC2
* AWS CloudFormation / CDK
  * Infrastructure as Code 
  * 可重複部署、減少人為錯誤
* AWS Trusted Advisor
  * 提供符合最佳實踐的自動化檢查與建議。
* AWS OpsWorks
* AWS X-Ray
* AWS CodePipeline
* CodeBuild
* CodeDeploy
* CodeCommit
* EventBridge
* Step Functions
* Service Catalog

## Security（安全性）
重點：身份、資料、網路、威脅防護
* AWS IAM
  * 使用者、角色、Policy 
  * Least Privilege 原則
* AWS KMS 
  * 金鑰管理（EBS / S3 / RDS 加密） 
  * Server-side encryption
* AWS Secrets Manager / Parameter Store 
  * 管理 DB password / API key 
  * 比硬寫在程式碼安全
* AWS WAF 
  * Web 攻擊防護（SQL Injection、XSS） 
* AWS Shield
  * DDoS 防護（Standard / Advanced）
* Amazon GuardDuty 
  * 威脅偵測（異常流量、可疑行為）
* AWS Security Hub
* Amazon Inspector
* AWS Cognito
* VPC (NACL/SG
* AWS Certificate Manager (ACM)
* AWS RAM 

## Reliability（可靠性）
重點：高可用、容錯、備份、災難復原
* Amazon EC2 Auto Scaling 
  * 自動補機器，避免單點故障
* Elastic Load Balancing（ALB / NLB） 
  * 分散流量、健康檢查
* Amazon RDS (Multi-AZ)
  * 自動 failover（SAA 必考）
* Amazon S3 
  * 11 個 9 的 durability 
  * 天生高可靠
* AWS Backup 
  * 集中管理備份策略
* Amazon Route 53 
  * Health Check + Failover routing
* Amazon Aurora Global
* Amazon EFS
* AWS Backup
* Amazon SQS
* Amazon SNS
* Amazon ElastiCache (Multi-AZ)

## Performance Efficiency（效能效率）
重點：選對服務、自動擴展、Managed Service
* Amazon EC2
  * Compute / Memory / Storage optimized
* AWS Lambda 
  * 無伺服器、事件驅動 
  * 間歇性流量超適合
* Amazon ECS
* Amazon EKS
* Amazon Fargate
* Amazon S3 Transfer Acceleration / Intelligent-Tiering
* Amazon DynamoDB 
  * 高吞吐、低延遲
  * Auto Scaling / On-Demand
* Amazon DynamoDB Accelerator
* Amazon ElastiCache（Redis / Memcached） 
  * 快取降低 DB 壓力
* Amazon CloudFront 
  * CDN，降低 latency
* AWS Compute Optimizer
* AWS Global Accelerator
* AWS Nitro Enclaves

# Cost Optimization（成本最佳化）
重點：付多少用多少、避免浪費
* AWS Cost Explorer 
  * 分析成本趨勢
* AWS Budgets 
  * 成本告警（超支通知）
* EC2 Pricing Models 
  * On-Demand / Reserved / Spot（SAA 愛考 Spot）
* S3 Storage Classes 
  * Standard / IA / Glacier / Deep Archive
* AWS Compute Optimizer 
  * 建議你該用什麼 instance
* Savings Plans / Reserved Instances (RI)
  * 承諾長期使用以換取大幅折扣
* Spot Instances
  * 利用 AWS 閒置產能，最高可節省 90% 的運算成本
* S3 Intelligent-Tiering
  * 自動根據數據訪問頻率調整儲存層級以節省費用
* Glacier
* One Zone-IA
* AWS Cost Anomaly Detection
* Pay-Per-Use
  * EC2 Auto Scaling
  * Spot Fleet
  * Lambda
  * Fargate
* AWS Compute Optimizer


# Sustainability (永續發展)
重點：減少浪費、提升資源使用率（SAA 新但會考概念）
* AWS Region 選擇（低碳地區）
* AWS Ec2 / Lambda / Fargate / Step Functions
  * Serverless
  * 高資源利用率
* Amazon EC2 Auto Scaling
  * 用多少開多少 
* Amazon EC2 Spot Instances
* Graviton Instances 
  * 更省電、更高效能
* S3 Lifecycle 
  * 自動轉低碳、低成本儲存層
* Amazon S3 (One Zone-IA, Glacier)
* AWS Customer Carbon Footprint Tool
  * 追蹤、衡量並預測你使用 AWS 服務產生的碳排放
* Serverless 服務 (Lambda, Fargate)
  * 透過共享資源減少硬體閒置，進而減少環境衝擊
* Managed Services (RDS, DynamoDB)
  * 由 AWS 優化基礎設施運作效率，而非用戶自行維護低效的虛擬機
* AWS Compute Optimizer

## [EC2](https://www.youtube.com/watch?v=8bIW7qlldLg)
* Overview of the Amazon Elastic Compute Cloud (EC2)
* Launch your first Amazon EC2 instance in the cloud
* Connect to Amazon EC2 Linux instance
* Connect to Amazon EC2 Windows instance
* Learn about AWS security groups and test with ICMP pings between instances
* Access EC2 instance metadata
* Access EC2 instance user data
* Amazon EC2 status checks and monitoring
* Learn the difference between public, private, elastic IP addresses
* Private IP addresses
* Public IP addresses
* Elastic IP addresses and Elastic Network Interfaces (ENIs)
* Create private subnets and bastion hosts
* NAT Instances and NAT Gateways
* Private subnet with NAT Gateway
* Private subnet with NAT Instance
* Learn how to connect to your private Amazon EC2 instances using agent forwarding
* Understand placement groups including cluster, partition and spread placement groups

## [S3](https://www.youtube.com/watch?v=oaZ3R4NCRu8)
* What is Cloud Computing?
* What is AWS?
* What is AWS S3?
* Benefits of AWS S3
* Objects and Buckets in AWS S3
* How does AWS S3 works
* Features of AWS S3

## [RDS](https://www.youtube.com/watch?v=lyBs2rhpVnE)
* Create Relation Database
* Allow EC2 to connect to RDS

## [ElastiCache Redis](https://www.youtube.com/watch?v=E_PuOTmfRJY)
* Compare ElastiCache Redis & Memcache
* Create ElastiCache Redis
* Allow EC2 to connect to ElastiCache Redis

## [Elasticache Memcache](https://www.youtube.com/watch?v=tmoJlRUD-No)
* Compare Elasticache Redis & Memcache
* Create Elasticache Memcache
* Allow EC2 to connect to Elasticache Memcache

## [IAM](https://www.youtube.com/watch?v=o0p04B7-NFY)
* What is AWS Security?
* Types of Security
* What is AWS IAM?
* Benefits of AWS IAM
* How AWS IAM works?
* Components of AWS IAM
* Features of IAM

## [VPC](https://www.youtube.com/watch?v=g2JOHLHh4rI)
* Introduction
* IPv4 Addressing Primer
* Amazon VPC Overview
* Defining VPC CIDR Blocks
* VPC Wizard
* Create a Custom VPC with Subnets
* Launch Instances and Test VPC
* Security Groups and Network ACL
* Configure Security Groups and NACLs
* Amazon VPC Peering
* Configure VPC Peering
* VPC Endpoints
* Create VPC Endpoint
* AWS Client VPN
* AWS Site-to-Site VPN
* AWS VPN CloudHub
* AWS Direct Connect (DX)
* AWS Direct Connect Gateway
* AWS Transit Gateway
* Using IPv6 in a VPC
* Create VPC Flow Logs

## [SNS](https://www.youtube.com/watch?v=Tc_Zx0ZT1fY)
* Create Topic
* Create Subscription

## [SES](https://www.youtube.com/watch?v=swdJPTQ6iJk)
* Introduction
* AWS SES Course Overview
* Basic Pricing for Amazon SES
* Most Common Uses for SES
* SES Terms of Service and Marketing E-Mail
* GDPR Considerations
* Set Up and Authentication
* Domain Authentication
* From E-Mail and Authentication
* Notifications and Authentication
* Deliverability: Domains
* Deliverability: Email Addresses
* Deliverability: Dedicated IP
* Content and Deliverability
* Testing Sites and Deliverability
* Double or Single Opt-In and Deliverability
* Using an Interface and SMTP Credentials
* AWS SES Interfaces
* Amazon SES Advanced Course Overview
* Server Based Systems and Technical Ability
* Cost Vs. Cloud Based Interfaces
* Mautic
* Sendy: Self-hosted Email Newsletter App
* Sendy: FTP File Permissions
* Sendy: Installation and IAM User Creation
* E-Mail Verification With Sendy
* Sendy: Wordpress Integration
* Cloud Based:  EmailOctopus
* EmailOctopus: SES Access
* EmailOctopus: Connection
* EmailOctopus: Promoting Website Domains
* EmailOctopus: Wordpress Installation
* How to Set Up WordPress SMTP Using Amazon SES
* WordPress Newsletter Plugin
* Conclusion

## [SQS](https://www.youtube.com/watch?v=vLNDaZuA3Dc)
* Create DynamoDB
* Create SQS
* Create Lambda Function
* Test 

## [Route 53](https://www.youtube.com/watch?v=BtiS0QyiTK8)
* What is AWS?
* Why Amazon Route 53?
* What is Amazon Route 53
* Benefits of Route 53
* Types of Routing Policy
* Amazon Route 53 Key Features
* Accessing Amazon Route 53
* Demo
 
## [CloudFront](https://www.youtube.com/watch?v=Vr4N_ZA-uGo)
* What is AWS?
* What is AWS CloudFront? 
* How AWS CloudFront Delivers the Content?
* Demo - How to Use CloudFront to Serve Private s3 Bucket as Website?

## [Elastic Load Balancer](https://www.youtube.com/watch?v=ghmisQh5_zw)
* How to create Elastic Load Balancer in AWS
* Introduction to AWS ELB
* Load Balancer
* Elastic Load Balancer
* Types of Elastic Load Balancer
* Classic Load Balancer
* Network Load Balancer
* Application Load Balancer
* Cross Zone Load Balancing
* Demo on Cross-Zone Load Balancing:
* Demo on Classic Load Balancer
* Demo on Application Load Balancer
* How to create a key pair

## [Auto Scaling](https://www.youtube.com/watch?v=-hFAWk6hyZA)
* What are Snapshots and AMIs?
* Why AutoScaling?
* What is AutoScaling?
* What is a Load Balancer?
* Hands-on

## [Cloud Watch](https://www.youtube.com/watch?v=__knpcBRLHg)
* What is Amazon CloudWatch?
* Why do we need Amazon CloudWatch Events?
* What does Amazon CloudWatch Logs do?
* Hands-on

## [Cloud Trail](https://www.youtube.com/watch?v=Vgi3ukxc1n0)
* Introduction
* Why do we  need CloudTrail?
* What is CloudTrail?
* Features of CloudTrail
* Functionality/Working
* Limitations of CloudTrail
* Demo: AWS CloudTrail
* CloudTrail vs CloudWatch
* Case Study