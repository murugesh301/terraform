# Using a single workspace:
terraform {
  required_version = ">= 0.12"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "rm3001"

    workspaces {
      prefix = "rm3001-"
    }
  }
}
#######
provider "aws" {
  region     = "ap-south-1"
}