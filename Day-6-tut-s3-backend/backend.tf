terraform {
  backend "s3" {
    bucket         = "tf-s3-sarth-3009"   
    key            = "global/terraform.tfstate"   
    region         = "ap-south-1"                   
    encrypt        = true                          
    dynamodb_table = "ddb-terraform-state-lock-3009"  
    workspace_key_prefix = "sarthak"                        
  }
}
