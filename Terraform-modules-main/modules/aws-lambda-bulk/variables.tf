variable "project_name" {
  description = "Project name (used for IAM role naming)"
  type        = string
}

variable "lambda_functions" {
  description = "Map of Lambda functions to create"
  type = map(object({
    function_name = string
    image_uri     = string
    memory_size   = number
    timeout       = number
  }))
}
