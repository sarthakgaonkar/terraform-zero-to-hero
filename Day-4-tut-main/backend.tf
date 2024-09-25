terraform {
  backend "s3" {
    bucket = "tf-s3-sarth-2509"
    key    = "sarthak/terraform.tfstate"
    region = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}