output "ecs_cluster_arn" {
  description = "ARN of ECS Cluster"
  value       = aws_ecs_cluster.hazelcast_ecs.arn
}

output "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.hazelcast_ecs.name
}

output "instance_public_ip" {
  description = "Public IP of the ECS EC2 instance"
  value       = aws_instance.hazelcast_instance.public_ip
}

output "instance_private_ip" {
  description = "Private IP of the ECS EC2 instance"
  value       = aws_instance.hazelcast_instance.private_ip
}