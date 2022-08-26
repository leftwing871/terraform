variable "tags" {
  
}

variable "my_ip" {
  
}

# EC2 Instance
variable "ami" {
  
}

variable "instance_type" {
  
}

variable "instance_subnet_id" {
  
}

variable "iam_instance_profile" {
  
}

# EC2 Load Balancer
variable "pulbic_subnets" {
  
}

variable "aws_security_group_ids" {
    type    = list(string)
}