provider "aws" {
  version = "~> 4.22.0"
  region  = "ap-south-1" 
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-ecr-repo" 
}


