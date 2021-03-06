variable "name" {
  description = "The name of the deployment"
}

variable "tags" {
  description = "Tags for the created resources"
}

variable "region" {
  description = "AWS Region"
}

variable "ami_id" {
  description = "ECS Optimised AWS EC2 AMI ID"
  default = ""
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

variable "hazelcast_discovery_tag_key" {
  description = "Hazelcast AWS Discovery Tag Key"
}

variable "instance_type" {
  description = "EC2 Instance type to launch for ECS"
}

variable "instance_count" {
  description = "EC2 Instance count"
  default     = 1
}

variable "hazelcast_members_count" {
  description = "Hazelcast members / tasks"
  default     = 1
}

variable "security_group_id" {
  description = "EC2 Security Group ID"
}

variable "subnet_id" {
  description = "EC2 Subnet ID"
}