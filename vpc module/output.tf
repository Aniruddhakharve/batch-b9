output "aws_vpc" {
  value       = aws_vpc.myvpc.id
  description = "It will show my vpc id when Ec2 instance is launch"
}

