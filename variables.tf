variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "vpc_name" {
  description = "Value of the Name tag for the VPC"
  type        = string
}

variable "tags" {
  type        = string
  default     = "value"
}

variable "product_name" {
  type        = string
}

variable "ami" {
  type        = string
}

variable "instance_type" {
  type        = string 
}

# variable "iam_instance_profile" {
#   type        = string
# }