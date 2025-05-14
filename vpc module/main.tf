



data "aws_security_group" "mysg" {
  id = "sg-0623015be8f4125b4"
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