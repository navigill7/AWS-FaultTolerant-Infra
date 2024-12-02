terraform {
backend "s3" {
    bucket         = "scalable-infra-bucket-777"
    dynamodb_table = "state-lock"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
}
}
