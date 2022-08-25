output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_2a_id" {
  value = aws_subnet.public_a.id
}

output "public_subnet_2c_id" {
  value = aws_subnet.public_c.id
}

output "private_subnet_2a_id" {
  value = aws_subnet.private_2a.id
}

output "private_subnet_2c_id" {
  value = aws_subnet.private_2c.id
}

# Private Subnet ap-northeast-2c ?