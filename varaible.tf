variable "regions" {
  type = map(object({
    cidr    = string
    subnets = map(object({
      cidr              = string
      map_public_ip     = bool
      availability_zone = string
    }))
  }))

  default = {
    "us-east-1" = {
      cidr = "10.0.0.0/16"
      subnets = {
        public-1 = {
          cidr              = "10.0.1.0/24"
          map_public_ip     = true
          availability_zone = "us-east-1a"
        }
        public-2 = {
          cidr              = "10.0.2.0/24"
          map_public_ip     = true
          availability_zone = "us-east-1b"
        }
        private-1 = {
          cidr              = "10.0.3.0/24"
          map_public_ip     = false
          availability_zone = "us-east-1a"
        }
        private-2 = {
          cidr              = "10.0.4.0/24"
          map_public_ip     = false
          availability_zone = "us-east-1b"
        }
        private-3 = {
          cidr              = "10.0.5.0/24"
          map_public_ip     = false
          availability_zone = "us-east-1a"
        }
        private-4 = {
          cidr              = "10.0.6.0/24"
          map_public_ip     = false
          availability_zone = "us-east-1b"
        }
      }
    }
    "us-west-1" = {
      cidr = "10.1.0.0/16"
      subnets = {
        public-1 = {
          cidr              = "10.1.1.0/24"
          map_public_ip     = true
          availability_zone = "us-west-1a" # Updated
        }
        public-2 = {
          cidr              = "10.1.2.0/24"
          map_public_ip     = true
          availability_zone = "us-west-1c" # Updated
        }
        private-1 = {
          cidr              = "10.1.3.0/24"
          map_public_ip     = false
          availability_zone = "us-west-1a" # Updated
        }
        private-2 = {
          cidr              = "10.1.4.0/24"
          map_public_ip     = false
          availability_zone = "us-west-1c" # Updated
        }
        private-3 = {
          cidr              = "10.1.5.0/24"
          map_public_ip     = false
          availability_zone = "us-west-1a" # Updated
        }
        private-4 = {
          cidr              = "10.1.6.0/24"
          map_public_ip     = false
          availability_zone = "us-west-1c" # Updated
        }
      }
    }
  }
}


variable "ami_region_1" {
  type = string
  default = "ami-005fc0f236362e99f"

}

variable "ami_region_2" {
  type = string
  default = "ami-0da424eb883458071"
}

variable "key_name" {
  default = "basiton"
}