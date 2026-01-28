module "vpc" {
  source            = "./modules/vpc"
  cidr_block        = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  vpc_name          = var.vpc_name
  az                = var.availability_zone
  subnet_public     = var.subnet_public
}