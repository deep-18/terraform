resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

data "aws_availability_zones" "availability_zone" {}

resource "aws_subnet" "pub_sub_1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pub_sub_1a_cidr
  availability_zone = data.aws_availability_zones.availability_zone.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_sub_1a"
  }
}

resource "aws_subnet" "pub_sub_2a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pub_sub_2a_cidr
  availability_zone = data.aws_availability_zones.availability_zone.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_sub_2a"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags={
    Name = "Route Table"
  }
}

# associate public subnet pub-sub-1a to public route table
resource "aws_route_table_association" "pub-sub-1a_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_1a.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "pub-sub-2-b_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_2a.id
  route_table_id      = aws_route_table.public_route_table.id
}


# create private app subnet pri-sub-3a
resource "aws_subnet" "pri_sub_3a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.pri_sub_3a_cidr
  availability_zone        = data.aws_availability_zones.availability_zone.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-3a"
  }
}

# create private app pri-sub-4b
resource "aws_subnet" "pri_sub_4b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.pri_sub_4a_cidr
  availability_zone        = data.aws_availability_zones.availability_zone.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-4b"
  }
}

# create private data subnet pri-sub-5a
resource "aws_subnet" "pri_sub_5a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.pri_sub_5a_cidr
  availability_zone        = data.aws_availability_zones.availability_zone.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-5a"
  }
}

# create private data subnet pri-sub-6-b
resource "aws_subnet" "pri_sub_6b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.pri_sub_6a_cidr
  availability_zone        = data.aws_availability_zones.availability_zone.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-6b"
  }
}