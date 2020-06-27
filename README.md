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

## Prerequisites

1. Configure AWS credentials. Refer [this](https://docs.aws.amazon.com/amazonswf/latest/awsrbflowguide/set-up-creds.html) for help.
2. Make sure your AWS user has permissions required to create all resources in the diagram
3. Install Terraform from [here](https://learn.hashicorp.com/terraform/getting-started/install.html)

## Usage

**Note:**
Change the inputs to match your requirement.

```hcl
module "hazelcast_cluster" {
    source                     = "path-to-the-module"
    name                       = "hazelcast"
    hazelcast_version          = "3.12.7"
    hazelcast_container_cpu    = 512
    hazelcast_container_memory = 1024
    instance_type              = "t3.small"
    security_group_id          = "security-group-id"
    subnet_id                  = "subnet-id"

    tags = {
      Environment = "Development"
      CreatedBy = "Terraform"
    }
}
```

## Examples

Try out the module functionality with an example defined [here](examples/single-node/main.tf).

1. Switch to examples directory `cd examples`
2. Initialize Terraform to download required plugins `terraform init`
3. Run `plan` to find out all resources that are going to be created `terraform plan`
4. Run `apply` to create those resources `terraform apply`
5. Install a [Hazelcast Client](https://hazelcast.org/imdg/clients-languages/) and test the connection
   with the instance public IP address
6. Make sure to destroy them once you are done exploring `terraform destroy`

## Inputs

| Name                          | Description                         |  Type  |      Default      | Required |
| ----------------------------- | ----------------------------------- | :----: | :---------------: | :------: |
| name                          | The name of the deployment          | string |       `n/a`       |   yes    |
| tags                          | Tags for the created resources      |  map   |       `n/a`       |   yes    |
| region                        | AWS Region                          | string |       `n/a`       |   yes    |
| hazelcast_version             | Hazelcast version to deploy         | string |      latest       |   yes    |
| hazelcast_container_cpu       | Hazelcast container CPU units       | string |       `n/a`       |   yes    |
| hazelcast_container_memory    | Hazelcast container memory          | string |       `n/a`       |   yes    |
| hazelcast_discovery_tag_key   | Hazelcast AWS Discovery Tag Key     | string | hazelcast_cluster |  false   |
| hazelcast_discovery_tag_value | Hazelcast AWS Discovery Tag Value   | string |     hazelcast     |  false   |
| members_count                 | Hazelcast members / tasks count     | number |         1         |  false   |
| instance_type                 | EC2 Instance type to launch for ECS | string |       `n/a`       |   yes    |
| instance_count                | EC2 Instance count                  | number |         1         |  false   |
| security_group_id             | EC2 Security Group ID               | string |       `n/a`       |   yes    |
| subnet_id                     | EC2 Subnet ID                       | string |       `n/a`       |   yes    |

## Outputs

| Name                | Description                           |
| ------------------- | ------------------------------------- |
| ecs_cluster_arn     | ARN of ECS Cluster                    |
| ecs_cluster_name    | Name of the ECS Cluster               |
| instance_public_ip  | Public IP of the ECS EC2 instance(s)  |
| instance_private_ip | Private IP of the ECS EC2 instance(s) |

## Contributing

We appreciate your help!

[Open an issue](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/issues/new/choose) or submit a pull request for an enhancement.
Browse through the
[current open issues](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/issues).

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Authors

[![Alt text](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/blob/master/diagrams/banner.png?raw=true)](https://everest.engineering)

[![License: EverestEngineering](https://img.shields.io/badge/Copyright%20%C2%A9-EVERESTENGINEERING-blue)](https://everest.engineering)
