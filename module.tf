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

# EC2 Security Group common
resource "aws_security_group" "ec2_common" {
  name     = "${var.general_tags}-ec2_common-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description      = "ingress from Load Balancer"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.general_tags}-sg"
  }
}

# EC2 Security Group for DB
resource "aws_security_group" "ec2_for" {
  name     = "${var.general_tags}-ec2_for-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description      = "ingress from Load Balancer"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.general_tags}-sg"
  }
}


module "ec2_fleet" {
  source = "./04_ec2_fleet"
  for_each = var.ec2-sm-tw-ldbgw-list

  # vpc_id               = module.vpc.vpc_id
  my_ip                = "221.148.114.22"
  ami                  = data.aws_ami.ubuntu.image_id # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  instance_type        = "t3.micro"
  instance_subnet_id   = module.vpc.private_subnet_2a_id
  pulbic_subnets       = [module.vpc.public_subnet_2a_id, module.vpc.public_subnet_2c_id]
  iam_instance_profile = module.iam.iam_name
  aws_security_group_ids = [aws_security_group.ec2_common.id, aws_security_group.ec2_for.id]

  tags = each.key

  depends_on = [
    module.vpc,
    module.iam,
    aws_security_group.ec2_common,
  ]
}


#Note
#1) 별도의 VPC 생성
#2) security group 생성
#3) db subnet 생성

module "rds_fleet" {
  source = "./05_rds"
  #for_each = var.rds-logdb-list
  for_each = { for key, value in var.rds-logdb-list : key => value if (value.switch == 1 && value.name != "rds-sm-tw-logdb-005" ) }

  # each.value.name
  tags = each.key
  instance_class = "db.r5.large"
  rdsinstance_availability_zone = "ap-northeast-2a"
  rdscluster_availability_zones = ["ap-northeast-2a", "ap-northeast-2b"]
  cluster_identifier = each.value.name
  vpc_security_group_ids = ["sg-031affd280f7d4d49"]
  db_subnet_group_name = "db-sunet-group"
  switch = each.value.switch
  
}