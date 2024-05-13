terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

#===========================Keypair
resource "aws_key_pair" "my-keypair" {
  key_name   = "my-keypair"
  public_key = file(var.keypair_path)
}
#====================================

module "network" {
  source = "./my-project/network"

  availability_zones = var.availability_zones
  cidr_block         = var.vpc_cidr_block
}

#====================================

module "security" {
  source = "./my-project/security"

  vpc_id         = module.network.vpc_id
  workstation_ip = var.workstation_ip

  depends_on = [
    module.network
  ]
}

#====================================

module "bastion-host" {
  source = "./my-project/bastion-host"

  instance_type = var.bastion_instance_type
  key_name      = aws_key_pair.my-keypair.key_name
  subnet_id     = module.network.public_subnets[0]
  sg_id         = module.security.bastion_sg_id
  ami           = var.bastion_ami
  depends_on = [
    module.network,
    module.security
  ]
}

#====================================

module "storage" {
  source = "./my-project/storage"

  instance_type = var.db_instance_type
  key_name      = aws_key_pair.my-keypair.key_name
  subnet_id     = module.network.private_subnets[0]
  sg_id         = module.security.mongodb_sg_id
  ami           = var.db_ami
  depends_on = [
    module.network,
    module.security
  ]
}

#====================================

module "app" {
  source = "./my-project/app"

  instance_type   = var.app_instance_type
  key_name        = aws_key_pair.my-keypair.key_name
  vpc_id          = module.network.vpc_id
  public_subnets  = module.network.public_subnets
  private_subnets = module.network.private_subnets
  webserver_sg_id = module.security.application_sg_id
  alb_sg_id       = module.security.alb_sg_id
  mongodb_ip      = module.storage.private_ip
  ami             = var.app_ami
  depends_on = [
    module.network,
    module.security,
    module.storage
  ]
}

