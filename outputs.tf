output "tags" {
  value = var.general_tags
}

# VPC Module
output "vpc_id" {
  value = module.vpc.vpc_id
}

# EC2 Module
output "ec2_dns" {
  value = module.ec2.ec2_dns
}

output "lb_dns" {
  value = module.ec2.lb_dns
}

# IAM Module
output "iam_name" {
  value = module.iam.iam_name
}