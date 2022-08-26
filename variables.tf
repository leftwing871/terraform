variable "general_tags" {
  default     = "default"
  type        = string
  description = "General Resource Tag"
}

variable "ec2-sm-tw-ldbgw-list" {
  type    = set(string)
}

variable "rds-logdb-list" {
  type    = map
}
