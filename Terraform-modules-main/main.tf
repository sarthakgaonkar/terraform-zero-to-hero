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

# variable "function_name" {
#   type        = string
#   description = "Lambda function name"
# }

# variable "image_uri" {
#   type        = string
#   description = "ECR image URI"
# }

# variable "memory_size" {
#   type        = number
#   default     = 512
# }

# variable "timeout" {
#   type        = number
#   default     = 30
# }

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

variable "function_name" {}
variable "image_uri" {}
variable "memory_size" {
  default = 512
}
variable "timeout" {
  default = 30
}

module "lambda_function" {
  source        = "./modules/aws-lambda"
  function_name = var.function_name
  image_uri     = var.image_uri
  memory_size   = var.memory_size
  timeout       = var.timeout
}

locals {
  lambda_functions = {
    lambda1 = {
      function_name = "lambda-1"
      image_uri     = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/my-lambda:latest"
      memory_size   = 512
      timeout       = 30
    }
    lambda2 = {
      function_name = "lambda-2"
      image_uri     = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/my-lambda:latest"
      memory_size   = 1024
      timeout       = 60
    }
    lambda3 = {
      function_name = "lambda-3"
      image_uri     = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/my-lambda:latest"
      memory_size   = 256
      timeout       = 15
    }
  }
}

module "lambda_functions" {
  source        = "./modules/aws-lambda-bulk"
  project_name  = "my-project"
  lambda_functions = local.lambda_functions
}

output "lambda_names" {
  value = module.lambda_functions.lambda_names
}