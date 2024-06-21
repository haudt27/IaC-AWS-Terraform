terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "Haudt-my-VPC"
  cidr = var.cidr_block

  azs             = var.availability_zones
  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
  public_route_table_tags = {
     "10.10.1.0/24" = "pub_subnet1"
      "10.10.2.0/24" = "pub_subnet2"}

  private_subnets = ["10.10.101.0/24", "10.10.102.0/24"]
  private_route_table_tags = {
      "10.10.101.0/24" = "pri_subnet1"
      "10.10.102.0/24" = "pri_subnet2"
}
  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Name = "Haudt-my-VPC"
    Demo = "Terraform"
  }
}
