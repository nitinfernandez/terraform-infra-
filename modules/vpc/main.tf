
resource "aws_vpc" "this" {
  cidr_block = var.cidr

  tags = {
    Name = var.name
  }
}


resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "${var.name}-subnet"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "subnet" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.public.id
}
