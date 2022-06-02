# AWS
觀看這篇筆及可以搭配[大話AWS雲端架構](https://www.tenlong.com.tw/products/9789864348022?list_name=srh)
，該書是講解概念，而這篇筆記則是在Youtube找出相關實作教學影片，極度建議把書看完一遍再看教學影片，
如果不看書的話也可以看此[Youtube]()來理解AWS提供的各服務在應用情境裡扮演的腳色。

下面Youtube實作教學的排序是按照個人經驗中服務的重要度以及常用程度來排序。

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

## [ElastiCache Memcache](https://www.youtube.com/watch?v=tmoJlRUD-No)
* Compare ElastiCache Redis & Memcache
* Create ElastiCache Memcache
* Allow EC2 to connect to ElastiCache Memcache

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