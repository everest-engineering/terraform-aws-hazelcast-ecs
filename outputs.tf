output "instance_public_ip" {
  description = "Public IP of the ECS EC2 instance"
  value = aws_instance.hazelcast_instance.public_ip
}