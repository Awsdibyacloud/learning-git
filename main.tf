provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  availability_zone   = "ap-south-1a"
}
resource "aws_security_group" "ec2_sg" {
  vpc_id = module.vpc.vpc_id
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

resource "aws_instance" "ec2" {
  ami           = "ami-0f58b397bc5c1f2e8" # Amazon Linux (update if needed)
  instance_type = "t2.micro"
  subnet_id     = module.vpc.subnet_id

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "My-EC2"
  }
}
