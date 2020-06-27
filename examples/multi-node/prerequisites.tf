locals {
  name         = "hazelcast"
  stage        = "Development"
  default_tags = {
    Environment = "Testing"
    CreatedBy   = "Terraform"
  }
}

module "vpc" {
  source                                          = "cloudposse/vpc/aws"
  version                                         = "0.10.0"
  namespace                                       = local.name
  stage                                           = local.stage
  name                                            = join("", [local.name, "-vpc"])
  cidr_block                                      = "10.0.0.0/16"
  enable_default_security_group_with_custom_rules = false
  tags                                            = local.default_tags
}

module "dynamic-subnets" {
  source             = "cloudposse/dynamic-subnets/aws"
  version            = "0.19.0"
  namespace          = local.name
  stage              = local.stage
  name               = join("", [local.name, "-instance-subnet"])
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  max_subnet_count   = 1
  availability_zones = ["ap-southeast-1a"]
  tags               = local.default_tags
}

resource "aws_security_group" "hazelcast_ecs_security_group" {
  name   = local.name
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5701
    to_port     = 5701
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.default_tags
}