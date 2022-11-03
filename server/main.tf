provider "aws" {
  region  = "ap-south-1" 
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-ecr-repo" 
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster" 
}

resource "aws_ecs_task_definition" "first_service" {
  family = "first_service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
    container_definitions    = <<EOF
[
  {
    "name": "demo-container",
    "image": "434828451347.dkr.ecr.ap-south-1.amazonaws.com/my-ecr-repo:1.0",
    "memory": 1024,
    "cpu": 512,
    "essential": true,
    "entryPoint": ["/"],
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOF
}
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = "${aws_iam_role.ecsTaskExecutionRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "my_first_service" {
  name            = "my_first-service"                             # Naming our first service
  cluster         = "${aws_ecs_cluster.my_cluster.id}"             # Referencing our created Cluster
  task_definition = "${aws_ecs_task_definition.first_service.arn}" # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 3 # Setting the number of containers we want deployed to 3
}

# Providing a reference to our default VPC
resource "aws_default_vpc" "default_vpc" {
}

# Providing a reference to our default subnets
resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "ap-south-1a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "ap-south-1b"
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = "ap-south-1c"
}




