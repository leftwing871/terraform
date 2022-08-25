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
