variable "region" {
  description = "Region that the instances will be created"
  default     = "ap-northeast-1"
}

variable "key_name" {
  type        = string
  description = "keypair name"
  default     = "ecs_fargate"
}


/*====
environment specific variables
======*/
# variable "production_secret_key_base" {
#   description = "The Rails secret key for production"
# }
