## Data source types

### Structured
Structured data is often organized to support transactional and analytical applications. Structured data is most commonly stored in relational databases but can also be stored in nonrelational databases. This data source type is valuable because you can gain insight into overarching trends by efficiently running powerful data queries and analysis.

### Semi-structured
Semi-structured data can be just as predictable and organized as structured data. The difference is that semi-structured data is flexible and can be updated without the requirement to change the schema for every single record in a table. Semi-structured data allows a user to capture any data in any structure as data evolves and changes over time. Semi-structured data is often stored in nonrelational stores.

### Unstructured
Unstructured data is not organized in any distinguishable or predefined manner. Common stores for unstructured data are nonrelational key-value databases. Unstructured data is full of irrelevant information, which means data needs to first be processed to perform any kind of meaningful analysis.

Examples of data considered to be unstructured are text messages, word processing documents, videos, photos, and other images. These files are not organized other than being placed into a file system, object store, or another repository such as a data lake.

## Working with multiple data types
It's not uncommon for a company to work with multiple data source types at any given time.
Imagine a retailer that must combine data from its point of sale (POS) system with clickstream data from its website. Both systems are constantly producing information—the POS system is producing structured data, which is stored in a relational database, while the clickstream data is generated in semi-structured XML files in a nonrelational document store. This business must find a way to process these two different data source types in meaningful ways to draw correlations between online product comments found in the clickstream data and sale retail location information found in the database.

## Types of databases supported by AWS
Depending on the database type, a database may support more than one data source type. It's important to know which databases support which data source type, so that you make the right business and planning decisions. For example, trying to design a relational database to scale like a key-value database will most likely cause performance issues.

Discover what data source types Amazon Web Service (AWS) supports based on the database type.

* A relational database is built to store structured data in tables using a defined schema.
* Key-value databases are a type of nonrelational database that store unstructured data in the form of key-value pairs.
* Document stores are a type of nonrelational database that store semi-structured and unstructured data in the form of files. 
* In-memory data stores can be used for both structured and semi-structured data sources.
* Graph databases are purpose-built to store any type of data: structured, semi-structured, or unstructured. 
* Ledger databases can be used for both structured and semi-structured data sources.
* Wide-column databases can be used for  structured data sources.
* Time-series databases can be used for structured data sources.