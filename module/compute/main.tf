# Instance for private-1
resource "aws_instance" "private_1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  security_groups = [var.ec2_sg]
  subnet_id                   = var.subnet_ids["private-1"]
  associate_public_ip_address = false
  key_name = var.key_name

  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
    echo "<h1>Welcome to Web Subnet (Private-1)</h1>" > /var/www/html/index.html
  EOT

  tags = {
    Name = "Private-EC2-private-1"
  }
}

# Instance for private-2
resource "aws_instance" "private_2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids["private-2"]
  security_groups = [var.ec2_sg]
  associate_public_ip_address = false
  key_name = var.key_name

  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
    echo "<h1>Welcome to Web Subnet (Private-2)</h1>" > /var/www/html/index.html
  EOT

  tags = {
    Name = "Private-EC2-private-2"
  }
}

# Instance for private-3
resource "aws_instance" "private_3" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids["private-3"]
  security_groups = [var.ec2_sg]
  associate_public_ip_address = false
  key_name = var.key_name
  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
    echo "<h1>Welcome to App Subnet (Private-3)</h1>" > /var/www/html/index.html
  EOT

  tags = {
    Name = "Private-EC2-private-3"
  }
}

# Instance for private-4
resource "aws_instance" "private_4" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids["private-4"]
  security_groups = [var.ec2_sg]
  associate_public_ip_address = false
  key_name = var.key_name

  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
    echo "<h1>Welcome to App Subnet (Private-4)</h1>" > /var/www/html/index.html
  EOT

  tags = {
    Name = "Private-EC2-private-4"
  }
}

