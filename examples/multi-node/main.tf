module "hazelcast_ecs_cluster" {
  source = "../../"

  name                       = "hazelcast"
  region                     = "ap-southeast-1"

  hazelcast_version          = "3.12.7"
  hazelcast_container_cpu    = 512
  hazelcast_container_memory = 1900

  instance_type              = "t3.medium"
  members_count             = 2

  security_group_id          = aws_security_group.hazelcast_ecs_security_group.id
  subnet_id                  = module.dynamic-subnets.public_subnet_ids[0]

  tags = {
    Environment = "Testing"
    CreatedBy   = "Terraform"
  }
}

output "public_ip" {
  description = "Public IP Address"
  value       = module.hazelcast_ecs_cluster.instance_public_ip
}