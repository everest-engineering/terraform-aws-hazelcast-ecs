This module is part of a project to simplify the provisioning of Hazelcast on AWS cloud using Terraform. You may also wish to consider [one of the other approaches](https://github.com/everest-engineering/terraform-aws-hazelcast).

# Terraform module to provision Hazelcast using AWS ECS

Terraform module that provisions Hazelcast container in ECS

This module creates the following resources required for Hazelcast container to be up and running in ECS cluster. 

1. ECS cluster
2. ECS task definition and service for provided version of Hazelcast
3. Roles required for EC2 to execute the task

### Approach: 

This approach creates an ECS task for Hazelcast and runs/manages that task on EC2 instance of provided instance type.

![Architecture](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/blob/master/diagrams/hazelcast_on_ecs.png?raw=true)

## Contributing
We appreciate your help!
 
[Open an issue](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/issues/new/choose) or submit a pull request for an enhancement. 
Browse through the 
[current open issues](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/issues).

## License
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Authors
[![Alt text](https://github.com/everest-engineering/terraform-aws-mongodb-ecs/blob/master/images/banner.png?raw=true)](https://everest.engineering)

[![License: EverestEngineering](https://img.shields.io/badge/Copyright%20%C2%A9-EVERESTENGINEERING-blue)](https://everest.engineering)
