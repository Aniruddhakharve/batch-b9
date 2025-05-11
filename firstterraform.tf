provider "aws" {
  
  region  = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c1ac8a41498c1a9c"
  instance_type = "t3.micro"
key_name = "ubuntu-rsa"
  tags = {
    Name = "HelloWorld"
  }
}