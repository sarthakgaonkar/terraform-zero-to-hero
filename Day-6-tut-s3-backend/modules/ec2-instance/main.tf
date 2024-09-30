provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "testinstance" {
  ami = var.ami_value
  instance_type = var.instance_type_value
#   key_name = var.key_pair_value != "" ? var.key_pair_value : null
}