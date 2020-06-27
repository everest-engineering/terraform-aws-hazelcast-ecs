variable "name" {
  description = "The name of the deployment"
}

variable "tags" {
  description = "Tags for the created resources"
}

variable "hazelcast_version" {
  description = "Hazelcast version to deploy"
}

variable "hazelcast_container_cpu" {
  description = "Hazelcast container CPU units"
}

variable "hazelcast_container_memory" {
  description = "Hazelcast container memory"
}

variable "instance_type" {
  description = "EC2 Instance type to launch for ECS"
}

variable "security_group_id" {
  description = "EC2 Security Group ID"
}

variable "subnet_id" {
  description = "EC2 Subnet ID"
}