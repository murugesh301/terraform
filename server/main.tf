provider "aws" {
  region  = "ap-south-1" 
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-ecr-repo" 
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster" 
}

