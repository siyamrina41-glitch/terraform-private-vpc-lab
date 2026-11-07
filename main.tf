terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region              = "ap-southeast-2"
  profile             = "default"
  allowed_account_ids = ["987956624261"]
}

resource "aws_vpc" "secure" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "cloudsec-private-vpc"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}

resource "aws_subnet" "isolated" {
  vpc_id                  = aws_vpc.secure.id
  cidr_block              = "10.30.1.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "cloudsec-isolated-subnet"
    Environment = "learning"
  }
}

resource "aws_route_table" "isolated" {
  vpc_id = aws_vpc.secure.id

  tags = {
    Name        = "cloudsec-isolated-route-table"
    Environment = "learning"
  }
}

resource "aws_route_table_association" "isolated" {
  subnet_id      = aws_subnet.isolated.id
  route_table_id = aws_route_table.isolated.id
}

resource "aws_security_group" "isolated" {
  name        = "cloudsec-isolated-sg"
  description = "Learning security group with no ingress or egress rules"
  vpc_id      = aws_vpc.secure.id

  tags = {
    Name        = "cloudsec-isolated-sg"
    Environment = "learning"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.secure.id

  tags = {
    Name        = "cloudsec-default-sg-no-rules"
    Environment = "learning"
  }
}

output "vpc_id" {
  value = aws_vpc.secure.id
}

output "subnet_id" {
  value = aws_subnet.isolated.id
}

output "route_table_id" {
  value = aws_route_table.isolated.id
}

output "security_group_id" {
  value = aws_security_group.isolated.id
}