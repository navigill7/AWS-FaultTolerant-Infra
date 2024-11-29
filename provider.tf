provider "aws" {
  alias  = "region_a"
  region = "us-east-1"
}

provider "aws" {
  alias  = "region_b"
  region = "us-west-1"
}
