terraform {
  backend "s3" {
    bucket = "iop-terraform-state"
    key    = "services/fargate"
    region = "us-east-1"
  }
}
