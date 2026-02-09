# Designing database solutions for performance efficiency

## Understand data characteristics

Determine if your workload requires transactions, how it interacts with data, and what its performance demands are. Use this data to select the best-performing database approach for your workload.

You can choose from many purpose-built database engines including relational, key-value, document, in-memory, graph, time-series, and ledger databases. By picking the best database to solve a specific problem (or a group of problems), you can break away from restrictive one-size-fits-all monolithic databases and focus on building applications to meet the needs of your customers.

## Evaluate specific database offerings

Make informed decisions when designing and planning your database solutions. Take the time to evaluate the services and storage options that are available. Explore the available configuration options to help optimize your database performance. This includes strategies for implementing provisioned IOPS, memory and compute resources, scalability, and caching.

## Collect and record database performance metrics

Use tools such as CloudWatch Logs and more that record performance measurements related to database performance. For example, measure transactions per second, slow queries, or system latency introduced when accessing the database. Use this data to understand the performance of your database systems.

## Choose data storage based on access patterns

Use the access patterns of your workload to select the appropriate services and technologies. For example, use relational database for workloads that require transactions. Implementing a key-value store will provide higher throughput with eventual consistency.

## Optimize data storage based on access patterns

Your access patterns and metrics will also guide performance decisions to optimize how data is stored or queried. Measure how optimization such as indexing, key distribution, data warehouse design, or caching strategies impact system performance and overall efficiency.