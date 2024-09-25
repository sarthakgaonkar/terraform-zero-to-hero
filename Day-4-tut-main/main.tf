provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example1" {
    ami           = "ami-0e53db6fd757e38c7"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    subnet_id = "subnet-0e28c4ada3c36f7f0"
}

resource "aws_instance" "example2" {
    ami           = "ami-0e53db6fd757e38c7"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    subnet_id = "subnet-0e28c4ada3c36f7f0"
}


resource "aws_s3_bucket" "s3bucket-tf" {
  bucket = "tf-s3-sarth-2509"
}


resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
 
  attribute {
    name = "LockID"
    type = "S"
  }
}

