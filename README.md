[![Maintained by Everest Engineering](https://img.shields.io/badge/maintained%20by-everest.engineering-%235849a6.svg)](https://github.com/everest-engineering/)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/everest-engineering/terraform-aws-hazelcast-ecs.svg?label=latest)](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)

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

For a single member deployment:

```hcl
module "hazelcast_cluster" {
    source                        = "path-to-the-module"
    region                        = "ap-southeast-1"
    name                          = "hazelcast"
    hazelcast_version             = "3.12.7"
    hazelcast_container_cpu       = 512
    hazelcast_container_memory    = 2048
    instance_type                 = "t3.small"
    security_group_id             = "security-group-id"
    subnet_id                     = "subnet-id"
    hazelcast_discovery_tag_key   = 'Purpose'

    tags = {
      Purpose = "Orders"
      Environment = "Development"
      CreatedBy = "Terraform"
    }
}
```

For a multi member deployment:

```hcl
module "hazelcast_cluster" {
    source                        = "path-to-the-module"
    region                        = "ap-southeast-1"
    name                          = "hazelcast"
    hazelcast_version             = "3.12.7"
    hazelcast_container_cpu       = 512
    hazelcast_container_memory    = 2048
    hazelcast_members_count       = 2
    instance_type                 = "t3.small"
    security_group_id             = "security-group-id"
    subnet_id                     = "subnet-id"
    instance_count                = 2
    hazelcast_discovery_tag_key   = 'Purpose'

    tags = {
      Purpose = "Orders"
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

| Name                        | Description                         |  Type  | Default                  | Required |
| --------------------------- | ----------------------------------- | :----: | ------------------------ | :------: |
| name                        | The name of the deployment          | string | `n/a`                    |   yes    |
| tags                        | Tags for the created resources      |  map   | `n/a`                    |   yes    |
| region                      | AWS Region                          | string | `n/a`                    |   yes    |
| ami_id                      | ECS Optimised AWS EC2 AMI ID        | string | latest ECS Optimised AMI |    no    |
| hazelcast_version           | Hazelcast version to deploy         | string | latest                   |   yes    |
| hazelcast_container_cpu     | Hazelcast container CPU units       | string | `n/a`                    |   yes    |
| hazelcast_container_memory  | Hazelcast container memory          | string | `n/a`                    |   yes    |
| hazelcast_discovery_tag_key | Hazelcast AWS Discovery Tag Key     | string | `n/a`                    |   yes    |
| hazelcast_members_count     | Hazelcast members / tasks count     | number | 1                        |    no    |
| instance_type               | EC2 Instance type to launch for ECS | string | `n/a`                    |   yes    |
| instance_count              | EC2 Instance count                  | number | 1                        |    no    |
| security_group_id           | EC2 Security Group ID               | string | `n/a`                    |   yes    |
| subnet_id                   | EC2 Subnet ID                       | string | `n/a`                    |   yes    |

**Notes:**

- Please note that the AMI provided must be an ECS Optimised AMI with Docker and ECS agent installed.
- `hazelcast_discovery_tag_key` will be used to configure auto discovery with Hazelcast AWS plugin

## Outputs

| Name                | Description                           |
| ------------------- | ------------------------------------- |
| ecs_cluster_arn     | ARN of ECS Cluster                    |
| ecs_cluster_name    | Name of the ECS Cluster               |
| instance_public_ip  | Public IP of the ECS EC2 instance(s)  |
| instance_private_ip | Private IP of the ECS EC2 instance(s) |

## Testing

#### Prerequisites

- Make sure you have installed JAVA and Docker
- Set the values `access-key` and `secret-key` in `tests/hazelcast-java-client/src/main/resources/hazelcast-client.yaml`
  with your AWS Access Keys

#### Setup

The test setup is automated in [setup.sh](tests/setup.sh). It does the following things:

1. Deploys the 'multi-node' example to AWS with Terraform
2. Verifies that the cluster has formed successfully
3. Builds the Docker image for the JAVA client
4. Runs the built Docker image
5. Verifies members discovery
6. Verifies client connection to the cluster

#### Teardown

Teardown of the test environment is automated in [teardown.sh](tests/teardown.sh).

1. Destroys the 'multi-node' example
2. Removes Docker images and containers

_Note:_ Don't forget to teardown the cluster to avoid incurring charges.

## Contributing

We appreciate your help!

[Open an issue](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/issues/new/choose) or submit a pull request for an enhancement.
Browse through the
[current open issues](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/issues).

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Authors

[![Authors: EverestEngineering](https://github.com/everest-engineering/terraform-aws-hazelcast-ecs/blob/master/diagrams/banner.png?raw=true)](https://everest.engineering)

[![License: EverestEngineering](https://img.shields.io/badge/Copyright%20%C2%A9-EVERESTENGINEERING-blue)](https://everest.engineering)
