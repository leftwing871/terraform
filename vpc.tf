# VPC
resource "aws_vpc" "this" {
  cidr_block = "100.0.0.0/16"

  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

# Public Subnet ap-northeast-2a
resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.this.id

  availability_zone = "ap-northeast-2a"
  cidr_block        = "100.0.0.0/24"

  tags = {
    Name = "${var.vpc_name}-public-2a"
  }
}

# Public Subnet ap-northeast-2c
resource "aws_subnet" "public_c" {
  vpc_id = aws_vpc.this.id

  availability_zone = "ap-northeast-2c"
  cidr_block        = "100.0.1.0/24"

  tags = {
    Name = "${var.vpc_name}-public-2c"
  }
}

# Private Subnet ap-northeast-2a
resource "aws_subnet" "private_2a" {
  vpc_id = aws_vpc.this.id

  availability_zone = "ap-northeast-2a"
  cidr_block        = "100.0.10.0/24"

  tags = {
    Name = "${var.vpc_name}-private-2a"
  }
}

# Private Subnet ap-northeast-2c
resource "aws_subnet" "private_2c" {
  vpc_id = aws_vpc.this.id

  availability_zone = "ap-northeast-2c"
  cidr_block        = "100.0.11.0/24"

  tags = {
    Name = "${var.vpc_name}-private-2c"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public_a.id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "${var.vpc_name}-nat"
  }
}

# EIP for NAT Gateway
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "${var.vpc_name}-eip"
  }
}

# Public Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Private Route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

# Routing table association for Public Subnet ap-northeast-2a
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# Routing table association for Public Subnet ap-northeast-2c
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

# Routing table association for Private Subnet ap-northeast-2a
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_2a.id
  route_table_id = aws_route_table.private.id
}

# Routing table association for Private Subnet ap-northeast-2c
resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_2c.id
  route_table_id = aws_route_table.private.id
}

# Public Routing
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.igw.id
}

# Private Routing
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.nat.id
}