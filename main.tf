#
# Cloudwatch Log Group
#
provider "aws" {}
}

resource "aws_cloudwatch_log_group" "fargate" {
  name = "${var.environment}_fargate"

  tags {
    Environment = "${var.environment}"
  }
}

#
# ECS cluster
#

resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-ecs-cluster"
}
