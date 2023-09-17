variable vpc_cidr_block {}
variable private_subnet_cidr_block {}
variable public_subnet_cidr_block {}


provider "aws" {
    region = "ap-southeast-2"
}

data "aws_availability_zones" "azs" {

}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  name = "myapp-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_block
  public_subnets = var.public_subnet_cidr_block
  azs = data.aws_availability_zones.azs.names
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    
  }

  public_subnet_tags = {
     "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
     "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
     "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
     "kubernetes.io/role/internal-elb" = 1 
  }


}