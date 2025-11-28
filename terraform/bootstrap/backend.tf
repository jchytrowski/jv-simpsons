terraform {
  backend "s3" {
    bucket = "boise-jellyvision-tfstate"
    key    = "tfstate/bootstrap"
    region = "us-east-1"
  }
}