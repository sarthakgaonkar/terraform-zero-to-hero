provider "aws" {
  region = "ap-south-1"
}

# resource "aws_s3_bucket" "s3bucket-tf" {
#   bucket = "tf-s3-sarth-3009"
# }

# resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
#   name = "ddb-terraform-state-lock-3009"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key = "LockID"
 
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

variable "ami_value" {
  description = "value for ami"
}

variable "instance_type_value" {
  description = "this is instance type"
}

# variable "key_pair_value" {
#   description = "key pair required?"
#   default = ""
# }

module "ec2_instance" {
  source = "./modules/ec2-instance"
  ami_value = var.ami_value
  instance_type_value = var.instance_type_value
#   key_pair_value = var.key_pair_value != "" ? var.key_pair_value : null
}