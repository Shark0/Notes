# PAAS
這篇筆記是以本人Springboot後端工程師經驗來思考若用AWS、GCP、AZURE有哪些方面要顧慮

* [AWS](aws/readme.md)
* [GCP](gcp/readme.md)
* [AZURE](azure/readme.md)

## Service
### Organization
#### Identity and Access Management
* [AWS - IAM](aws/service/iam.md)
* [GCP - IAM](https://cloud.google.com/iam/docs?hl=zh-cn)
* [Azure - AD](https://learn.microsoft.com/zh-tw/windows-server/identity/identity-and-access)

### Front - End
####  Container
* AWS - EKS
* [AWS - EC2](aws/service/ec2.md)
* [AWS - EC2 Auto Scaling](aws/service/ec2_auto_scaling.md)
* [GCP - Compute Engine](https://cloud.google.com/products/compute/?hl=zh-cn)
* [GCP - GKE](https://cloud.google.com/kubernetes-engine?hl=zh-TW)
* [Azure - VM](https://learn.microsoft.com/zh-tw/azure/virtual-machines/)
* [Azure - App Service](https://learn.microsoft.com/zh-tw/azure/app-service/)
* [Azure - AKS](https://learn.microsoft.com/zh-tw/azure/aks/)

#### Queue
* [AWS - SQS](aws/service/sqs.md)
* [GCP - Pub/Sub](https://cloud.google.com/pubsub/?hl=zh-cn)
* [Azure - Queue](https://learn.microsoft.com/zh-tw/azure/storage/queues/)

#### Notification
* [AWS - SNS](aws/service/sns.md)
* [GCP - Cloud Messaging](https://firebase.google.com/docs/cloud-messaging?hl=zh-tw)
* [Azure - Notification Hub](https://learn.microsoft.com/zh-tw/azure/notification-hubs/)

#### Serverless Function
* [AWS - Lambda](aws/service/lambda.md)
* [GCP - Cloud Run](https://cloud.google.com/run?hl=zh-TW)
* [Azure - Function](https://learn.microsoft.com/zh-tw/azure/azure-functions/)

#### Storage
* [AWS - S3](aws/service/s3.md)
* [GCP - Cloud Storage](https://cloud.google.com/storage?hl=zh-TW)
* [Azure - Blob](https://docs.microsoft.com/zh-tw/azure/storage/blobs/)
* [Azure - File](https://docs.microsoft.com/zh-tw/azure/storage/files/)

#### Proxy & Load Balance
* [AWS - Elastic Load Balance](aws/service/api_getway.md)
* [GCP - Identity-Aware Proxy](https://cloud.google.com/security/products/iap?hl=zh-TW)
* [GCP - Secure Web Proxy](https://cloud.google.com/security/products/secure-web-proxy?hl=zh-TW)
* [GCP - Load Balance](https://cloud.google.com/load-balancing?hl=zh-tw)
* [Azure - Load Balancer](https://learn.microsoft.com/zh-tw/azure/load-balancer/)

#### API Gateway
* [AWS - API Gateway](aws/service/api_getway.md)
* [GCP - API Gateway](https://cloud.google.com/api-gateway?hl=zh-tw)
* [Azure - API Gateway](https://learn.microsoft.com/zh-tw/azure/api-management/api-management-gateways-overview)

#### CDN
* [AWS - Cloudfront](aws/service/cloudfront.md)
* [GCP - CDN](https://cloud.google.com/cdn?hl=zh-TW)
* [Azure - Front Door & CDN](https://learn.microsoft.com/zh-TW/azure/frontdoor/)

#### DNS
* [AWS - Route 53](aws/service/route53.md)
* [Azure - DNS](https://learn.microsoft.com/zh-tw/azure/dns/)

#### Database
* [AWS - RDS](aws/service/rds.md)
* [AWS - Elasticache](aws/service/elasticache.md)
* [GCP - SQL](https://cloud.google.com/sql/?hl=zh-tw)
* [GCP - Datastore](https://cloud.google.com/datastore?hl=zh-tw)
* [Azure - Mysql](https://docs.microsoft.com/zh-tw/azure/mysql)
* [Azure - Cosmos DB](https://learn.microsoft.com/zh-tw/azure/cosmos-db/)
* [Azure - Redis](https://learn.microsoft.com/zh-tw/azure/azure-cache-for-redis/)

### Monitor
* [AWS - Cloudwatch](aws/service/cloudwatch.md)
* [AWS - Cloudtrail](aws/service/cloudtrail.md)
* [GCP - Observability](https://cloud.google.com/products/operations?hl=zh-cn)
* [Azure - Log Analytics](https://learn.microsoft.com/zh-tw/azure/azure-monitor/logs/log-analytics-overview)

### Devops
#### Network
* [AWS - VPC](aws/service/vpc.md)
* [GCP - VPC](https://cloud.google.com/vpc?hl=zh-tw)
* [Azure - VNet](https://learn.microsoft.com/zh-tw/azure/virtual-network/virtual-networks-overview)

#### Resource Management
* [AWS - Cloudformation](aws/service/cloudfront.md)
* [GCP - Resource Manager](https://cloud.google.com/resource-manager?hl=zh-tw)
* [Azure - ARM](https://learn.microsoft.com/zh-tw/azure/azure-resource-manager)