provider "aws" {}

locals {
  tags = "${map(
    "ComcastApplicationName", "${var.app_name}",
    "ComcastApplicationRole", "${var.role}",
    "ComcastApplicationEnvironment", "${var.environment}",
    "ComcastDataClassification", "${var.data_classification}",
    "ComcastVPCClassification", "${var.vpc_classification}"
  )}"
}

resource "aws_cloudwatch_log_group" "fargate" {
  name = "${var.environment}_fargate"
  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-ecs-cluster"
}

resource "aws_ecr_repository" "repo" {
  name = "${var.environment}-ecr-repo"
}

resource "aws_ecr_repository_policy" "policy" {
  repository = "${aws_ecr_repository.repo.name}"

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}
