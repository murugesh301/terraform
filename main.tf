locals {
  production_availability_zone = "ap-south-1"
}

module "servers" {
  source            = "./server"
  environment       = var.environment
  availability_zone = local.production_availability_zone
  #aws_ecr_repository = my_ecr_repo
}

