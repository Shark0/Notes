# Designing database solutions for sustainability

## Minimize data movement across networks

When considering data storage, minimize data movement across networks and store data as close to the consumer as possible. The database services such as Amazon RDS and Aurora provide cross-Region replicas to reduce latency while maximizing the energy required for technology hardware. DynamoDB offers global tables, which provide users fast application performance with multi-active replication to AWS Regions worldwide.

## Reduce and reuse required resources

Implement ways to reduce CPU and network utilization. One example of this is using connection pooling to reuse and reduce required resource. Many applications can have several open connections to the database memory and compute resources. With services such as Amazon RDS Proxy, applications can pool and share connections established with the database, improving database efficiency and application scalability.