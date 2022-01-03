/*====
Variables used across all modules
======*/
locals {
  production_availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
}

provider "aws" {
  region = var.region
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.keygen.public_key_openssh
}

module "networking" {
  source               = "./modules/networking"
  environment          = "production"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.10.0/24", "10.0.20.0/24"]
  region               = var.region
  availability_zones   = local.production_availability_zones
  key_name             = aws_key_pair.key_pair.key_name
}

module "rds" {
  depends_on        = [module.networking]
  source            = "./modules/rds"
  environment       = "production"
  allocated_storage = "20"
  engine            = "postgres"
  engine_version    = "13.3"
  database_name     = var.production_database_name
  database_username = var.production_database_username
  database_password = var.production_database_password
  subnet_ids        = "${module.networking.private_subnets_id}"
  vpc_id            = module.networking.vpc_id
  instance_class    = "db.t3.micro"
}
