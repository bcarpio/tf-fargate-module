#
# Fargate Cluster
#
variable "workspace_iam_roles" {
  default = {
    deve = "arn:aws:iam::<dev_account_num>:role/svc_terraform"
    test = "arn:aws:iam::<tst_account_num>:role/svc_terraform"
    stag = "arn:aws:iam::<stg_account_num>:role/svc_terraform"
    prod = "arn:aws:iam::<prd_account_num>:role/svc_terraform"
  }
}

provider "aws" {
  assume_role {
    role_arn = "${var.workspace_iam_roles[terraform.workspace]}"
  }
}

resource "aws_cloudwatch_log_group" "fargate_ecs" {
  name = "${var.environment}_fargate_ecs"

  tags = {
    Environment = "${var.environment}"
  }
}

#
# ECS cluster
#

resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-ecs-cluster"
}
