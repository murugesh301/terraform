locals {
  production_availability_zone = "ap-south-1"
}

module "servers" {
  source            = "./server"
  environment       = var.environment
}