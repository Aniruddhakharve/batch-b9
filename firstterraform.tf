terraform {
  backend "s3" {
    bucket = "anubatch-b9"
    region = "ap-south-1"
    key = "terraform.tfstate"
    
  }
}

provider "aws" {
  
  region  = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0e35ddab05955cf57"
  instance_type = var.instance_type
key_name = "mumbai-01"
  tags = {
    Name = "HelloWorld"
  }
}

variable "instance_type" {
  default = "t2.micro"
  description = "this variable is created for initilizing instance using variable input"
  
}

output "instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP address of the EC2 instance"
}

output "instance_private_ip" {
  value       = aws_instance.web.private_ip
  description = "The private IP address of the EC2 instance"
}