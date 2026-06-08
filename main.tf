provider "aws" {
  region = "eu-west-1"
}
#VPC
resource "aws_vpc" "main"{
    cidr_block = var.vpc_cidr

    tags = {
        Name = "demo-vpc"
    }
}

#Subnet

resource "aws_subnet" "public"{
    vpc_id = aws.vpc.main.id

    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "demo-subnet"
  }

}


# Security Group
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.main.id

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

resource "aws_instance" "web" {
  ami           = "ami-0c94855ba95c71c99" # Amazon Linux (may vary per lab)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "demo-ec2"
  }
}


resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-demo-bucket-12345"
}