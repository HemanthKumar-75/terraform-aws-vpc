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
  cidr_block        = var.public_subnet_cidrblocks[count.index]
  availability_zone = local.az_names[count.index]
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
