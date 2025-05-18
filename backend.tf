terraform {
  backend "s3" {
    bucket = "reactor-terraform-state"
    key    = "ecs/fargate"
  }
}
