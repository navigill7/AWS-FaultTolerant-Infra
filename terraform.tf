terraform {
backend "s3" {
    bucket         = "scalable-infra-bucket-752"
    dynamodb_table = "state-lock"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
}
}