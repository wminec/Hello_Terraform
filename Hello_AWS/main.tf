# Terraform 설정
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


# provider 설정
provider "aws" {
  region = "us-east-1"
}

# VPC 생성
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
}

# 서브넷 생성
resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
}

# 라우팅 테이블 생성
resource "aws_route_table" "example_rt" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}

# 서브넷에 라우팅 테이블 연결
resource "aws_route_table_association" "example_rta" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_rt.id
}

# 보안 그룹 생성
resource "aws_security_group" "example_sg" {
  name_prefix = "example-sg"
  vpc_id      = aws_vpc.example_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 키페어 생성
resource "aws_key_pair" "example_keypair" {
  key_name   = "example-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Public IP 생성
resource "aws_eip" "example_eip" {
  vpc = true
}

# EC2 인스턴스에 Public IP 연결
resource "aws_eip_association" "example_eip_assoc" {
  instance_id   = aws_instance.example_instance.id
  allocation_id = aws_eip.example_eip.id
}

# EC2 인스턴스 생성
resource "aws_instance" "example_instance" {
  ami                    = "ami-0c9978668f8d55984"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.example_keypair.key_name
  subnet_id              = aws_subnet.example_subnet.id
  vpc_security_group_ids = [aws_security_group.example_sg.id]

  tags = {
    Name = "example-instance"
  }
}
