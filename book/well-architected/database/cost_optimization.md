# Designing database solutions for cost optimization

## AWS Auto Scaling

One of the advantages of the cloud in general is the ability to auto scale. AWS Auto Scaling works with Aurora and DynamoDB. It is a fully managed service that will automatically scale based on your workload. This way, you won't overpay to prepare for increases in demand.

## Read replicas

Using read replicas with auto scaling in Aurora is a great way to control costs. Automatically scaling results in only paying for what you are using. For example, rather that creating many databases to cover a workload, resulting in paying for under-utilized databases during slower times, you can use read replicas with auto scaling. In this case, you will only be paying for additional replicas when your read queries reach certain thresholds.