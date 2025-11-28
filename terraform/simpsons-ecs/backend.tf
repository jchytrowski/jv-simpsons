terraform {
  backend "s3" {
    bucket = "boise-jellyvision-tfstate"
    key    = "tfstate/chytrowski"
    region = "us-east-1"
  }
}