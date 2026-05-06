# ==========================================
# VPC
# ==========================================
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name      = var.vpc_name
    Terraform = "true"
  }
}

# ==========================================
# Subnets (8 Subnets - Multi AZ)
# ==========================================
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = { Name = "Public-Subnet-AZ1" }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true
  tags = { Name = "Public-Subnet-AZ2" }
}

resource "aws_subnet" "frontend_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.frontend_subnet_a_cidr
  availability_zone = "${var.aws_region}a"
  tags = { Name = "Frontend-Private-AZ1" }
}

resource "aws_subnet" "frontend_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.frontend_subnet_b_cidr
  availability_zone = "${var.aws_region}b"
  tags = { Name = "Frontend-Private-AZ2" }
}

resource "aws_subnet" "backend_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.backend_subnet_a_cidr
  availability_zone = "${var.aws_region}a"
  tags = { Name = "Backend-Private-AZ1" }
}

resource "aws_subnet" "backend_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.backend_subnet_b_cidr
  availability_zone = "${var.aws_region}b"
  tags = { Name = "Backend-Private-AZ2" }
}

resource "aws_subnet" "db_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.db_subnet_a_cidr
  availability_zone = "${var.aws_region}a"
  tags = { Name = "DB-Private-AZ1" }
}

resource "aws_subnet" "db_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.db_subnet_b_cidr
  availability_zone = "${var.aws_region}b"
  tags = { Name = "DB-Private-AZ2" }
}

# ==========================================
# Internet Gateway & NAT Gateways
# ==========================================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = { Name = "Project-IGW" }
}

resource "aws_eip" "nat_eip_a" { domain = "vpc" }
resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.public_a.id
  tags          = { Name = "NAT-GW-AZ1" }
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip_b" { domain = "vpc" }
resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.public_b.id
  tags          = { Name = "NAT-GW-AZ2" }
  depends_on    = [aws_internet_gateway.igw]
}

# ==========================================
# Route Tables
# ==========================================
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "Public-RT" }
}

resource "aws_route_table_association" "pub_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt_a" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }
  tags = { Name = "Private-RT-AZ1" }
}

resource "aws_route_table_association" "front_a" {
  subnet_id      = aws_subnet.frontend_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route_table_association" "back_a" {
  subnet_id      = aws_subnet.backend_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route_table_association" "db_a" {
  subnet_id      = aws_subnet.db_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route_table" "private_rt_b" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }
  tags = { Name = "Private-RT-AZ2" }
}

resource "aws_route_table_association" "front_b" {
  subnet_id      = aws_subnet.frontend_b.id
  route_table_id = aws_route_table.private_rt_b.id
}

resource "aws_route_table_association" "back_b" {
  subnet_id      = aws_subnet.backend_b.id
  route_table_id = aws_route_table.private_rt_b.id
}

resource "aws_route_table_association" "db_b" {
  subnet_id      = aws_subnet.db_b.id
  route_table_id = aws_route_table.private_rt_b.id
}
