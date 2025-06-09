provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias = "tokyo"  
  region = "ap-northeast-1"
}


resource "aws_vpc" "my-vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "pvt-sub1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.cidr_block_subnet1
  availability_zone = var.az-ap-south-1a
}

resource "aws_subnet" "pvt-sub2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.cidr_block_subnet2
  availability_zone = var.az-ap-south-1b
}

resource "aws_subnet" "public-sub1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.cidr_block_subnet3
  availability_zone = var.az-ap-south-1a
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public-sub2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.cidr_block_subnet4
  availability_zone = var.az-ap-south-1b
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route_table" "pvt_rt1" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = var.pvt-rt-table-cidr
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"  
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
}

resource "aws_route_table" "public-rt1" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0" #this means everything inside a vpc
    gateway_id = aws_internet_gateway.igw.id
  }

}


resource "aws_route_table_association" "pvt-assoc-1" {
  route_table_id = aws_route_table.pvt_rt1.id
  subnet_id = aws_subnet.pvt-sub1.id
  
}

resource "aws_route_table_association" "pvt-assoc-2" {
  route_table_id = aws_route_table.pvt_rt1.id
  subnet_id = aws_subnet.pvt-sub2.id
  
}

resource "aws_route_table_association" "public-assoc-1" {
  route_table_id = aws_route_table.public-rt1.id
  subnet_id = aws_subnet.public-sub1.id
}

resource "aws_route_table_association" "public-assoc-2" {
  route_table_id = aws_route_table.public-rt1.id
  subnet_id = aws_subnet.public-sub2.id
}

resource "aws_eip" "elastic-ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public-sub1.id

  tags = {
    Name = "gw NAT"
  }

  # If you're still depending on the IGW, you can keep this (or remove if not needed)
  depends_on = [aws_internet_gateway.igw]
}
