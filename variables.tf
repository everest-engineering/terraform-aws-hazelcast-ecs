variable "name" {
  description = "The name of the deployment"
  default = ""
}

variable "tags" {
  description = "Tags for the created resources"
  default = ""
}

variable "hazelcast_version" {
  description = "Hazelcast version to deploy"
  default = ""
}

variable "hazelcast_container_cpu" {
  description = "Hazelcast container CPU units"
  default = ""
}

variable "hazelcast_container_memory" {
  description = "Hazelcast container memory"
  default = ""
}

variable "instance_type" {
  description = "EC2 Instance type to launch for ECS"
  default = ""
}

variable "security_group_id" {
  description = "EC2 Security Group ID"
  default = ""
}

variable "subnet_id" {
  description = "EC2 Subnet ID"
  default = ""
}