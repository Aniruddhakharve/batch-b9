resource "aws_instance" "web" {
  ami           = "ami-0e35ddab05955cf57"
  instance_type = var.instance_type
key_name = "mumbai-01"
vpc_security_group_ids = [data.aws_security_group.mysg.id]
 tags = {
    Name =  var.project_name
  }
}