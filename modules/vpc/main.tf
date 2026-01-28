resource "aws_vpc" "main_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.az
  map_public_ip_on_launch = var.subnet_public

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-subnet"
    Type = var.subnet_public ? "public" : "private"
  })
}

resource "aws_internet_gateway" "gw" {
  count  = var.subnet_public ? 1 : 0
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "rt" {
  count  = var.subnet_public ? 1 : 0
  vpc_id = aws_vpc.main_vpc.id

  dynamic "route" {
    for_each = var.subnet_public ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw[0].id
    }
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-rt"
  })
}

resource "aws_route_table_association" "a" {
  count = var.subnet_public ? 1 : 0

  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.rt[0].id
}