
resource "aws_vpc" "VPC" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "VPC-${var.region}"
  }
}


resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                 = aws_vpc.VPC.id
  cidr_block             = each.value.cidr
  map_public_ip_on_launch = each.value.map_public_ip
  availability_zone      = each.value.availability_zone

  tags = {
    Name = "${var.region}-Subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "${var.region}-igw"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.VPC.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.region}-Public-Route-Table"
  }
}


resource "aws_route_table_association" "public_subnet_associations" {
  for_each = { for key, value in var.subnets : key => value if value.map_public_ip }

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eips" {
  for_each = {
    "public-1" = var.subnets["public-1"]
    "public-2" = var.subnets["public-2"]
  }

  vpc = true
}

# NAT Gateways in public-1 and public-2
resource "aws_nat_gateway" "nat_gateways" {
  for_each = aws_eip.nat_eips

  allocation_id     = aws_eip.nat_eips[each.key].id
  subnet_id         = aws_subnet.subnets[each.key].id
  connectivity_type = "public"

  tags = {
    Name = "${var.region}-NAT-Gateway-${each.key}"
  }
}

# Private Route Tables (One for public-1 NAT Gateway and one for public-2 NAT Gateway)
resource "aws_route_table" "private_route_tables" {
  for_each = {
    "nat-public-1" = "public-1"
    "nat-public-2" = "public-2"
  }

  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways[each.value].id
  }

  tags = {
    Name = "${var.region}-Private-Route-Table-${each.key}"
  }
}

# Associate NAT Route Table public-1 with private-1 and private-3
resource "aws_route_table_association" "private_1_and_3_associations" {
  for_each = {
    "private-1" = aws_subnet.subnets["private-1"]
    "private-3" = aws_subnet.subnets["private-3"]
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_tables["nat-public-1"].id
}

# Associate NAT Route Table public-2 with private-2 and private-4
resource "aws_route_table_association" "private_2_and_4_associations" {
  for_each = {
    "private-2" = aws_subnet.subnets["private-2"]
    "private-4" = aws_subnet.subnets["private-4"]
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_tables["nat-public-2"].id
}



resource "aws_instance" "bastion_hosts" {
  for_each           = { for key, value in var.subnets : key => value if value.map_public_ip && contains(["public-1", "public-2"], key) }
  ami                = var.bastion_ami
  instance_type      = var.instance_type
  subnet_id          = aws_subnet.subnets[each.key].id
  key_name           = var.key_pair_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.region}-Bastion-Host-${each.key}"
  }
}







