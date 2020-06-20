This module is part of a project to simplify the provisioning of Hazelcast on AWS cloud using Terraform. You may also wish to consider [one of the other approaches](https://github.com/everest-engineering/terraform-aws-hazelcast).

# Terraform module to provision Hazelcast using AWS ECS

Terraform module that provisions Hazelcast container in ECS

This module creates the following resources required for Hazelcast container to be up and running in ECS cluster.

1. ECS cluster
2. ECS task definition and service for provided version of Hazelcast
3. Roles required for EC2 to execute the task

### Approach:

This approach creates an ECS task for Hazelcast and runs/manages that task on EC2 instance of provided instance type.

![Architecture](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/blob/master/diagrams/hazelcast_imdg_on_ecs.png?raw=true)

## Inputs

| Name                       | Description                         |  Type  | Default | Required |
| -------------------------- | ----------------------------------- | :----: | :-----: | :------: |
| name                       | The name of the deployment          | string |  `n/a`  |   yes    |
| tags                       | Tags for the created resources      |  map   |   {}    |   yes    |
| hazelcast_version          | Hazelcast version to deploy         | string |  `n/a`  |   yes    |
| hazelcast_container_cpu    | Hazelcast container CPU units       | string |  `n/a`  |   yes    |
| hazelcast_container_memory | Hazelcast container memory          | string |  `n/a`  |   yes    |
| instance_type              | EC2 Instance type to launch for ECS | string |  `n/a`  |   yes    |
| security_group_id          | EC2 Security Group ID               | string |  `n/a`  |   yes    |
| subnet_id                  | EC2 Subnet ID                       | string |  `n/a`  |   yes    |

## Outputs

| Name                | Description                        |
| ------------------- | ---------------------------------- |
| ecs_cluster_arn     | ARN of ECS Cluster                 |
| ecs_cluster_name    | Name of the ECS Cluster            |
| instance_public_ip  | Public IP of the ECS EC2 instance  |
| instance_private_ip | Private IP of the ECS EC2 instance |

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
