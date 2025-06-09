provider "aws" {
  region = "ap-south-1"
}

# resource "aws_s3_bucket" "s3bucket-tf" {
#   bucket = "tf-s3-sarth-backend-0906"
# versioning {
#     enabled = true
#   }

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }
# }

# resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
#   name = "ddb-terraform-state-lock-0906"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key = "LockID"
 
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

resource "aws_s3_bucket" "example" {
  bucket = "my-app-${terraform.workspace}-1006"
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

variable "cidr_block" {
  description = "cidr block ips"
}

variable "cidr_block_pvtsub1" {
  description = "cidr for subnet1"
}

variable "cidr_block_pvtsub2" {
  description = "cidr for subnet2"
}

variable "cidr_block_pubsub1" {
  description = "cidr for subnet3"
}

variable "cidr_block_pubsub2" {
  description = "cidr for subnet4"
}

variable "az-ap-south-1a" {
  description = "az ap-south-1a"
}

variable "az-ap-south-1b" {
  description = "az ap-south-1b"
}

variable "pvt-rt-table-cidr" {
  description = "cidr block for pvt rt table"
}


module "my_vpc_1" {
  source = "./modules/aws-vpc"
  cidr_block = var.cidr_block
  cidr_block_subnet1 = var.cidr_block_pvtsub1
  cidr_block_subnet2 = var.cidr_block_pvtsub2
  cidr_block_subnet3 = var.cidr_block_pubsub1
  cidr_block_subnet4 = var.cidr_block_pubsub2
  az-ap-south-1a = var.az-ap-south-1a
  az-ap-south-1b = var.az-ap-south-1b
  pvt-rt-table-cidr = var.pvt-rt-table-cidr

}