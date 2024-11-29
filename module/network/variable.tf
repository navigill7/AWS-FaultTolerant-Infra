variable "cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr              = string
    map_public_ip     = bool
    availability_zone = string
  }))
}

variable "bastion_ami" {
  type = string

  
}


variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_pair_name" {
  type = string
  default = "basiton"
}




