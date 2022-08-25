module "vpc" {
  source = "./01_vpc"

  tags = var.general_tags
}

module "ec2" {
  source = "./02_ec2"

  vpc_id               = module.vpc.vpc_id
  my_ip                = "221.148.114.22"
  ami                  = data.aws_ami.ubuntu.image_id # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  instance_type        = "t3.micro"
  instance_subnet_id   = module.vpc.private_subnet_2a_id
  pulbic_subnets       = [module.vpc.public_subnet_2a_id, module.vpc.public_subnet_2c_id]
  iam_instance_profile = module.iam.iam_name

  tags = var.general_tags

  depends_on = [
    module.vpc,
    module.iam
  ]
}

module "iam" {
  source = "./03_iam"

  tags = var.general_tags
}