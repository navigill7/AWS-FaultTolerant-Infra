variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the instances"
}

variable "instance_type" {
  type        = string
  default = "t2.micro"
}

variable "subnet_ids" {
  description = "Map of private subnet IDs"
  type        = map(string)
}


variable "key_name" {
  type = string
}


variable "ec2_sg" {
  type = string
}


