terraform {
  backend "s3" {
    bucket         = "terraform-s3-deep"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dynamo-demo"
  }
}