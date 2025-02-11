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
module "ec2"{
  source = "./modules/ec2"
  pub_sub_1a_id = module.vpc.pub_sub_1a_id
  pub_sub_2a_id = module.vpc.pub_sub_2a_id
  sg = module.sg.sg
  key_name = var.key_name
}
module "sg"{
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}
module "asg" {
  source = "./modules/asg"
  project_name = var.project_name
  alb_sg = module.sg.sg
  ami = module.ec2.ami
  # max_size = var.max_size
  # min_size = var.min_size
  # desired_cap = var.desired_cap
  # asg_health_check_type = var.asg_health_check_type
  pri_sub_4b_id = module.vpc.pri_sub_4b_id
  pri_sub_3a_id = module.vpc.pri_sub_3a_id
  key_name = var.key_name
}