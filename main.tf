resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.dns_hostnames
  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
      Name = local.resources_name
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
      Name = local.resources_name
    }
  )
}

resource "aws_subnet" "public" {
  count  = length(var.public_subnet_cidrblocks)
  vpc_id = aws_vpc.main.id
  # cidr_block = var.public_subnet_cidrblocks[*]
  # availability_zone = local.az_names[*]
  cidr_block              = var.public_subnet_cidrblocks[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = merge(
    var.common_tags,
    var.public_subnet_tags,
    {
      Name = "${local.resources_name}-public-${local.az_names[count.index]}"
      #   Name = local.subnet_name
    }
  )
}

resource "aws_subnet" "private" {
  count  = length(var.private_subnet_cidrblocks)
  vpc_id = aws_vpc.main.id
  # cidr_block = var.private_subnet_cidrblocks[*]
  # availability_zone = local.az_names[*]
  cidr_block        = var.private_subnet_cidrblocks[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
    var.common_tags,
    var.private_subnet_tags,
    {
      Name = "${local.resources_name}-private-${local.az_names[count.index]}"
      #   Name = local.subnet_name
    }
  )
}

resource "aws_subnet" "database" {
  count  = length(var.database_subnet_cidrblocks)
  vpc_id = aws_vpc.main.id
  # cidr_block = var.database_subnet_cidrblocks[*]
  # availability_zone = local.az_names[*]
  cidr_block        = var.database_subnet_cidrblocks[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
    var.common_tags,
    var.database_subnet_tags,
    {
      Name = "${local.resources_name}-database-${local.az_names[count.index]}"
      #   Name = local.subnet_name
    }
  )
}

# database subnet group for RDS
resource "aws_db_subnet_group" "default" {
  name       = local.resources_name
  subnet_ids = aws_subnet.database[*].id

  tags = merge(
    var.common_tags,
    var.database_subnet_tags,
    {
      Name = local.resources_name
    }
  )
}

resource "aws_eip" "NAT" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    var.NAT_tags,
    {
      Name = local.resources_name
    }
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.NAT.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    var.nat_gateway_tags,
    {
      Name = local.resources_name
    }
  )

  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_route_table" "public_routes" {
  vpc_id = aws_vpc.main.id

    tags = merge(
    var.common_tags,
    var.public_routes_tags,
    {
      Name = "${local.resources_name}-public"
    }
  )
}

resource "aws_route_table" "private_routes" {
  vpc_id = aws_vpc.main.id

    tags = merge(
    var.common_tags,
    var.private_routes_tags,
    {
      Name = "${local.resources_name}-private"
    }
  )
}

resource "aws_route_table" "database_routes" {
  vpc_id = aws_vpc.main.id

    tags = merge(
    var.common_tags,
    var.database_routes_tags,
    {
      Name = "${local.resources_name}-database"
    }
  )
}

resource "aws_route" "public_internet_routing" {
  route_table_id            = aws_route_table.public_routes.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route" "private_internet_routing" {
  route_table_id            = aws_route_table.private_routes.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id  = aws_nat_gateway.nat_gateway.id
}

resource "aws_route" "database_internet_routing" {
  route_table_id            = aws_route_table.database_routes.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id  = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table_association" "public" {
  count = length(var.database_subnet_cidrblocks)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_routes.id
}

resource "aws_route_table_association" "private" {
  count = length(var.database_subnet_cidrblocks)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_routes.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrblocks)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database_routes.id
}