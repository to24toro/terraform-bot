resource "aws_vpc" "bybit" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
      Name="bybit"
  }
}

resource "aws_subnet" "bybit" {
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  vpc_id = aws_vpc.bybit.id

  map_public_ip_on_launch = true

  tags = {
      Name="bybit"
  }
}

resource "aws_internet_gateway" "bybit" {
  vpc_id = aws_vpc.bybit.id

  tags = {
    "Name" = "bybit"
  }
}

resource "aws_route_table" "bybit" {
    vpc_id = aws_vpc.bybit.id

    tags = {
    "Name" = "bybit"
  }
}

resource "aws_route" "bybit" {
  gateway_id = aws_internet_gateway.bybit.id
  route_table_id = aws_route_table.bybit.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "bybit" {
  subnet_id      = aws_subnet.bybit.id
  route_table_id = aws_route_table.bybit.id
}

resource "aws_security_group" "bybit" {
  vpc_id = aws_vpc.bybit.id
  name = "bybit"

  tags = {
    "Name" = "bybit"
  }
}

resource "aws_security_group_rule" "bybit_ssh" {
  security_group_id = aws_security_group.bybit.id
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 22
  to_port = 22
  protocol = "tcp"
}

resource "aws_security_group_rule" "bybit_out" {
  security_group_id = aws_security_group.bybit.id
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 0
  to_port = 0
  protocol = "-1"
}