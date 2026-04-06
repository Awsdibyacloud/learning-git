resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "public-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
}
