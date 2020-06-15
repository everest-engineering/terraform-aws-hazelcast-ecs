module "hazelcast_ecs_cluster" {
  source = "../../"

  name                       = "hazelcast"
  hazelcast_version          = "latest"
  hazelcast_container_cpu    = 512
  hazelcast_container_memory = 1024
  instance_type              = "t3.medium"
  security_group_id          = aws_security_group.hazelcast-ecs-security-group.id
  subnet_id                  = module.dynamic-subnets.public_subnet_ids[0]

  tags = {
    Environment = "Testing"
    CreatedBy = "Terraform"
  }
}