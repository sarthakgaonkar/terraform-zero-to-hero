terraform {
  backend "s3" {
    bucket = "tf-s3-sarth-backend-0906"
    key = "global/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "ddb-terraform-state-lock-0906"  
    workspace_key_prefix = "sarthak" 
  }
}