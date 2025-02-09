######################
# VPC and Networking #
######################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "iac-gitops-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "iac-gitops-public-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "iac-gitops-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "iac-gitops-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

#####################
# EC2 Instance      #
#####################

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "iac-gitops-ec2-instance"
  }
}

#####################
# RDS Instance      #
#####################

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = var.db_engine
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true

  vpc_security_group_ids = [] # You may add security groups as needed
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = {
    Name = "iac-gitops-rds"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "iac-gitops-db-subnet-group"
  subnet_ids = [aws_subnet.public.id]

  tags = {
    Name = "iac-gitops-db-subnet-group"
  }
}

#####################
# S3 Bucket         #
#####################

resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name = "iac-gitops-s3-bucket"
  }
}
