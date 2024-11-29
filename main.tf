module "network_region_a" {
  source = "./module/network"

  providers = {
    aws = aws.region_a
  }

  cidr    = var.regions["us-east-1"].cidr
  region  = "us-east-1"
  subnets = var.regions["us-east-1"].subnets
  bastion_ami = var.ami_region_1
}

module "network_region_b" {
  source = "./module/network"

  providers = {
    aws = aws.region_b
  }

  cidr    = var.regions["us-west-1"].cidr
  region  = "us-west-1"
  subnets = var.regions["us-west-1"].subnets
  bastion_ami = var.ami_region_2
}

module "compute_region_a" {
  source = "./module/compute"
  ec2_sg = module.security_region_1.ec2_sg
  key_name = var.key_name
  providers = {
    aws = aws.region_a
  }

  ami_id        = var.ami_region_1
  subnet_ids    = module.network_region_a.private_subnet_ids
}

module "compute_region_b" {
  source = "./module/compute"
  key_name = var.key_name
  ec2_sg = module.security_region_2.ec2_sg
  providers = {
    aws = aws.region_b
  }

  ami_id        = var.ami_region_2
  subnet_ids    = module.network_region_b.private_subnet_ids
}

module "security_region_1" {
  providers = {
    aws = aws.region_a
  }
  source = "./module/security"
  vpc_id = module.network_region_a.vpc_id
}
module "security_region_2" {
  providers = {
    aws = aws.region_b
  }
  source = "./module/security"
  vpc_id = module.network_region_b.vpc_id
}

module "alb_region-1" {
  providers = {
    aws = aws.region_a
  }
  source = "./module/LoadBalancer"
  alb_sg = module.security_region_1.alb_sg
  vpc_id = module.network_region_a.vpc_id
  private_instance_ids = module.compute_region_a.private_instance_ids
  public_subnet_ids = module.network_region_a.public_subnet_ids
}

module "alb_region-2" {
  providers = {
    aws = aws.region_b
  }
  source = "./module/LoadBalancer"
  alb_sg = module.security_region_2.alb_sg
  vpc_id = module.network_region_b.vpc_id
  private_instance_ids = module.compute_region_b.private_instance_ids
  public_subnet_ids = module.network_region_b.public_subnet_ids
}

