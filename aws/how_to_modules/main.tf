module "s3Module" {
  source = "./modules/s3"
}

module "sgModule" {
  source = "./modules/sg"
}

module "ec2Module" {
  source = "./modules/ec2"
  private_subnet_id = module.vpcModule.private_subnet_id
  my_sg = module.sgModule.my_sg
}

module "vpcModule" {
  source = "./modules/vpc"
}
