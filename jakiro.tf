resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id 
  cidr_block = "10.100.0.0/25"
  availability_zone = var.region
  map_public_ip_on_launch = false

  tags = {
    made_by = "jaka"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id 
  cidr_block = "10.100.0.128/25"
  availability_zone = var.region
  map_public_ip_on_launch = true

  tags = {
    made_by = "jaka"
  }
}
