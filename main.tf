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



data "aws_security_group" "mysg" {
  id = "sg-0623015be8f4125b4"
}


resource "aws_instance" "web" {
  ami           = "ami-0e35ddab05955cf57"
  instance_type = var.instance_type
key_name = "mumbai-01"
vpc_security_group_ids = [data.aws_security_group.mysg.id]

connection {
    type        = "ssh"
    user        = "ubuntu"  # For Ubuntu AMIs
    private_key = file("C:/Users/Aniruddha/Downloads/mumbai-01.pem")
    host        = self.public_ip
  }

provisioner "file" {
    source      = "C:/Users/Aniruddha/Downloads/terraform.pdf"
    destination = "/home/ubuntu/terraform.pdf"
  }


  tags = {
    Name =  var.project_name

  }
}



resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
    project = var.project_name
  }
}



resource "aws_subnet" "public_subnet" {
vpc_id = aws_vpc.myvpc.id
cidr_block = var.pub_cidr
tags = {
    Name = "${var.project_name}_public_subnet"
    project = var.project_name
  }
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
}



resource "aws_subnet" "private_subnet" {
vpc_id = aws_vpc.myvpc.id
cidr_block = var.pvt_subnet
tags = {
    Name = "private_subnet"
    project = var.project_name
  }
  map_public_ip_on_launch = false
  availability_zone = "ap-south-1b"
}




resource "aws_internet_gateway" "myigw" {
vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myigw"
    project = var.project_name
  }
  
}




resource "aws_route_table" "myroutetable" {
  vpc_id = aws_vpc.myvpc.id 
  tags = {
    Name = "myroutetable"
   project = var.project_name
  }
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
}
}