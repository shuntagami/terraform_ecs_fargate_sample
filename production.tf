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
