resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "private" {
  count = var.private_subnet_count

  cidr_block = cidrsubnet(var.cidr_block, 4, count.index)
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-private-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count = var.public_subnet_count

  cidr_block = cidrsubnet(var.cidr_block, 4, count.index + 4)
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-internet-gateway"
  }
}

resource "aws_route_table" "private" {
  count = var.private_subnet_count

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-private-${count.index}-route-table"
  }
}

resource "aws_route_table_association" "private" {
  count = var.private_subnet_count

  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table" "public" {
  count = var.public_subnet_count

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-public-${count.index}-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = var.public_subnet_count

  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}


resource "aws_route" "public_internet_gateway" {
  count = var.public_subnet_count

  route_table_id = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}