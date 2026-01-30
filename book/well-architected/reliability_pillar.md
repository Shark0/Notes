# Reliability Pillar

## What is the reliability pillar?
The ability of a workload to perform its required function correctly and consistently over an expected period of time

## Reliability design principles
* Automatically recover from failure.
* Test recovery procedures.
* Scale horizontally to increase aggregate workload availability
* Stop guessing capacity
* Manage change in automation

## Reliability best practice areas
* Foundations
* Workload architecture
* Change management
* Failure management

## Manage service quotas and constraints
* Stay aware of service quotas and constraints 
* Manage service quotas across accounts and Regions
* Accommodate fixed service quotas and constraints through architecture
* Monitor and manage quotas
* Automate quota management
* Ensure a sufficient gap exists between current quotas and maximum usage

## Plan your network topology
* Use highly available network connectivity for you workload public endpoints
* Provision redundant connectivity between cloud and on-premises environments
* Ensure IP subnet allocation accounts for expansion and availability
* Prefer hub-and-spoke topologies over many-to-many mesh
* Enforce non-overlapping private IP ranges in connected address spaces

## Design your workload service architecture
* Choose how to segment your workload
* Build services focused on specific business domains and functionality
* Provide service contracts per API

## Design interactions in a distributed system to prevent failures
* Identify which kind of distributed system is required
* Implement loosely coupled dependencies
* Do constant work
* Make all responses idempotent

## Design interactions in a distributed system to mitigate
* Implement graceful degradation to transform hard dependencies to soft
* Throttle requests
* Control and limit retry calls
* Fail fast and limit queues
* Set client timeouts
* Make services stateless where possible
* Implement emergency levers

## Monitor workload resources
* Monitor all components for the workload (generation)
* Define and calculate metrics (aggregation)
* Sned notifications (real-time processing and alarming)
* Automate responses (real-time processing and alarming)
* Perform analytics
* Conduct reviews regularly
* Monitor end-to-end tracing of requests through your system

## Design a workload to adapt to changes in demand
* User automation when obtaining or scaling resources
* Obtain resources upon detection of impairment to a workload
* Obtain resources upon detection that more resources are needed for a workload
* Load test your workload

## Implement change
* User runbooks for standard activities such as deployment
* Integrate functional testing as part of your deployment
* Integrate resiliency testing as part of your deployment
* Deploy using immutable infrastructure
* Deploy changes with automation

## Back up data
* Identify and back up all data than needs to be backed up
* Secure and encrypt backups
* Perform data backup automatically
* Perform periodic recovery of data to verify backup integrity and processes

## Use fault isolation to protect your workload
* Deploy workload to multiple locations
* Select appropriate locations for your multi-location deployment
* Automate recovery for components constrained to a single location
* Use bulkhead architectures to limit scope of impact

## Design workload to withstand component failures
* Monitor all components of workload to detect failures
* Fail over to healthy resources
* Automate healing on all layers
* Rely on data plane, note control plane, during recovery
* Use static stability to prevent bimodal behavior 
* Send notifications when events impact availability
* Architect product to meet availability targets and uptime SLAs

## Test reliability
* User playbooks to investigate failures
* Perform post-incident analysis
* Test functional requirements 
* Test scaling and performance requirements
* Test resiliency using chaos engineering
* Conduct game days regularly
* Define recovery objectives for downtime and data loss
* Use defined recovery strategies to meet recovery objectives
* Test disaster recovery implementation to validate implementation
* Manage configuration drift at the DR site or Region
* Automate recovery

Plan for disaster recovery