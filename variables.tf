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

variable "production_database_name" {
  description = "The database name for Production"
}

variable "production_database_username" {
  description = "The username for the Production database"
}

variable "production_database_password" {
  description = "The user password for the Production database"
}

variable "production_secret_key_base" {
  description = "The Rails secret key for production"
}
