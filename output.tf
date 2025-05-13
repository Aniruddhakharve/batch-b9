output "instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP address of the EC2 instance"
}

output "instance_private_ip" {
  value       = aws_instance.web.private_ip
  description = "The private IP address of the EC2 instance"
}