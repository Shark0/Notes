# Architecture Overview
The previous lessons covered the different database types that Amazon Web Service (AWS) supports and the AWS database services available to you. You also got a quick look at the tools available to migrate your databases to AWS.

There is a lot to consider when choosing the right database solution networking options, security decisions, and more. While all of those are important, for this course, we are going to focus on another decision to make regarding your database deployment: server-based or serverless?

## Architecture
### Benefits of a server-based architecture
#### Developer Perspective
* Predictive tasks: For tasks that use constant or predictive compute, it may be more cost-effective to use server-based billing.
* Testing and debugging: Debugging is less complicated because there is visibility into backend processes and the application is not broken up into separate, smaller functions. It's difficult to replicate the serverless environment to see how code will actually perform once deployed.
* Fewer units of integration: Serverless architecture has fewer components compared to server-based architectures, which helps save time.

#### Business Perspective
* Overall control: The company owns and manages the infrastructure, which provides full control over all aspects of the application.
* Compliance and security: Having full control over the infrastructure allows for full visibility, which might be required for compliance and security standards.
* Legacy applications: Existing applications might not have the flexibility of decoupling individual parts and might be better suited to migrate to a server-based architecture.

### Benefits of a serverless architecture
#### Developer Perspective
* Server management: Because there is no backend infrastructure to be responsible for, liability is reduced and there is no system administration.
* Scalability: With a serverless architecture, you don’t have to think twice about provisioning infrastructure because of its ability to automatically scale with traffic volumes.
* Application flexibility: You can migrate individual application features or partial workloads to run on serverless as on-demand events. This frees up resources in production to be used for more critical tasks.

#### Business Perspective
* Time to market: Smaller deployable units result in faster delivery of features to market, increasing the ability to adapt to change.
* Cost: The cost of hiring backend infrastructure engineers goes down, along with operational costs.
* Customer obsession: Abstraction from servers lets companies dedicate more time and resources to developing and improving customer experience.
* Startup friendly: With the serverless architecture pay-as-you-go model, you can build an environment at a low cost and ease into the market without dealing with huge bills for minimum traffic.