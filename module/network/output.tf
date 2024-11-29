output "vpc_id" {
  value = aws_vpc.VPC.id
}

output "subnets" {
  value = aws_subnet.subnets
}

output "public_subnet_ids" {
  value = {
    for key, subnet in aws_subnet.subnets :
    key => subnet.id if subnet.map_public_ip_on_launch
  }
}


output "private_subnet_ids" {
  description = "Map of private subnet IDs"
  value = {
    for key, subnet in aws_subnet.subnets :
    key => subnet.id if !subnet.map_public_ip_on_launch
  }
}

