# What is Amazon DocumentDB?

Amazon DocumentDB (with MongoDB compatibility) is a fast, reliable, and fully managed database service. Amazon DocumentDB makes it easy to set up, operate, and scale MongoDB-compatible databases in the cloud. With Amazon DocumentDB, you can run the same application code and use the same drivers and tools that you use with MongoDB.

## Use Case: Online user profile architecture
Document databases are a great solution to store and query online profiles. For this use case, this architecture is one way you can provide user profile information for a web application. To learn more about this architecture example, choose each of the two numbered markers.

![img_21.png](image/img_21.png)

### AWS Elastic Beanstalk
Elastic Beanstalk is an straightforward service for deploying and scaling web applications and services developed with common web programming languages.

In this architecture, Elastic Beanstalk is hosting a web application that relies on user profile data to personalize the pages the user sees.

### Amazon DocumentDB
In this architecture, Amazon DocumentDB holds the data on each user who uses the web application. The first time they visit the site, they are prompted to provide information that the application can use on future visits.

Elastic Beanstalk searches the Amazon DocumentDB database for the pertinent information and then uses it to personalize the user's experience.

## Use Case: Real-time mobile web application architecture
Building high-performance mobile applications that scale to process millions of user requests per second with millisecond latency can be challenging. For this use case, this architecture is one way you could build a mobile application to deliver real-time stock information and recommendations. To learn more about this architecture example, choose each of the three numbered markers.

![img_22.png](image/img_22.png)

### Amazon API Gateway
API Gateway is a fully managed service that facilitates developers creating, publishing, maintaining, monitoring, and securing APIs at any scale.

In this architecture, API Gateway passes user requests to a microservice hosted in Amazon Elastic Container Service (Amazon ECS).

### Amazon ECS
Amazon ECS is a highly scalable, high-performance container orchestration service that supports Docker containers and streamlines running and scaling containerized applications on AWS.

In this architecture, Amazon ECS is hosting an application that provides stock information and makes buy and sell recommendations. The data for this application is hosted in Amazon DocumentDB.

### Amazon DocumentDB
In this architecture, all of the data required by the application is stored in an Amazon DocumentDB database. The application queries this data each time a user makes a request.