variable "alb_sg" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_instance_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs where ALB will be deployed"
  type        = map(string)
}
