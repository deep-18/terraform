module "vpc" {
  source = "./modules/vpc"
#   region = var.region
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  pub_sub_1a_cidr = var.pub_sub_1a_cidr
  pub_sub_2a_cidr = var.pub_sub_2a_cidr
  pri_sub_3a_cidr = var.pri_sub_3a_cidr
  pri_sub_4a_cidr = var.pri_sub_4a_cidr
  pri_sub_5a_cidr = var.pri_sub_5a_cidr
  pri_sub_6a_cidr = var.pri_sub_6a_cidr
}