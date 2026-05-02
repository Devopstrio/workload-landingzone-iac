terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "../../modules/networking"

  vpc_cidr    = "10.0.0.0/16"
  environment = "dev"
}

module "security" {
  source = "../../modules/security"

  vpc_id      = module.networking.vpc_id
  environment = "dev"
}

module "app_compute" {
  source = "../../modules/compute"

  subnet_id         = module.networking.app_subnet_id
  security_group_id = module.security.app_sg_id
  instance_type     = "t3.micro"
  environment       = "dev"
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "app_instance_id" {
  value = module.app_compute.instance_id
}
