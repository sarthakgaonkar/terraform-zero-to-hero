variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "image_uri" {
  description = "ECR image URI for Lambda (account.dkr.ecr.region.amazonaws.com/repo:tag)"
  type        = string
}

variable "memory_size" {
  description = "Memory allocated to Lambda"
  type        = number
  default     = 512
}

variable "timeout" {
  description = "Timeout in seconds"
  type        = number
  default     = 30
}