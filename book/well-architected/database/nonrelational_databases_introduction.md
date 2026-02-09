# What is Amazon Aurora?
Aurora is a MySQL- and PostgreSQL-compatible relational database built for the cloud that combines the performance and availability of traditional enterprise databases with the simplicity and cost-effectiveness of open-source databases.

Aurora is up to five times faster than standard MySQL databases and three times faster than standard PostgreSQL databases. It provides the security, availability, and reliability of commercial databases at one-tenth the cost. Aurora is fully managed by Amazon RDS, which automates time-consuming administration tasks such as hardware provisioning, database setup, patching, and backups.

## Use Case: Public source data ingestion architecture
Many applications rely on data from public sources to meet the needs of their users. Suppose your database needs to gather public weather information. For this use, this architecture is one way to accomplish this task. For more information, choose each of the six numbered marker.

### Public data source
Public data is everywhere. Using it to enhance the abilities of your applications and analysis can be the difference between having a functional app and having one that is a huge success.

In this architecture, data is being gathered from a website containing a public weather data source.

### Gather
Kinesis Data Firehose is a service that can capture, transform, and load streaming data into an S3 bucket. The result is called a data stream.

In this architecture, Kinesis Data Firehose gathers data from the weather website and sends it on to a Lambda function.

### Process
Lambda lets you run code called functions without provisioning or managing servers.

In this architecture, the Lambda function takes the data from the data stream and transforms it into a consistent format before storing it in an S3 bucket.

### Raw Store
Amazon S3 is a data repository.

In this architecture, Amazon S3 holds the data gathered by the Lambda function.

### Migration
AWS Database Migration Service (AWS DMS) migrates data from one source into an AWS database service.

In this architecture, AWS DMS takes the data from the S3 bucket, transforms it, and loads it into an Aurora table within the designated database.

### Final store
In this architecture, Aurora can now take the data from the table created by AWS DMS and use it to enrich the other data generated and used by applications accessing the database.

### Use Case: Log analytics architecture

Knowing how your databases are being used and their health is an important part of maintaining well-running systems. Aurora regularly generates logs on activities of users and the database. You can analyze these logs to ensure that users are getting the responses they require and the database is running optimally. For this use case, this architecture is one option for creating a log analytics system. For more information, choose each of the six numbered marker.

#### Amazon Aurora
Aurora is the database system.
In this architecture, users access the database through an application. Logging the activity of the application can help you to determine if it is running properly and meeting the needs of your users.

#### Amazon CloudWatch
CloudWatch is a monitoring and management service that provides you with the data and actionable insights to monitor and understand what is going on in your applications.

In this architecture, CloudWatch gathers the log files containing the activities of users and basic database operations. You can also export these logs to Amazon S3.

#### Amazon OpenSearch Service
Amazon OpenSearch is a fully managed service that helps you securely ingest data from any source and search, analyze, and visualize the data in real time.

In this architecture, Amazon OpenSearch gathers data from the CloudWatch logs, catalogs it, and makes it available for analysis and visualization.

#### Amazon QuickSight
QuickSight is a fast, cloud-powered business intelligence service that facilitates delivering insights to everyone in your organization.

In this architecture, QuickSight can visualize data contained within Amazon OpenSearch. That data reflects usage of the Aurora database.

#### Amazon S3
An Amazon S3 bucket is a storage location for many types of data.

In this architecture, you can store the log files from CloudWatch indefinitely for future analysis and to meet retention requirements.

#### Athena
Athena is an interactive query service that facilitates analyzing data in Amazon S3 using standard SQL.

In this architecture, you can use Athena to query the archived log files.