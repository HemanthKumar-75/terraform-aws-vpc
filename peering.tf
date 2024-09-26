resource "aws_vpc_peering_connection" "expense-default" {
  count = var.is_peering_required ? 1 : 0
  #   peer_owner_id = var.peer_owner_id # AWS account ID
  peer_vpc_id = data.aws_vpc.default.id # acceptor
  vpc_id      = aws_vpc.main.id         # requestor
  auto_accept = true 

  tags = merge(
    var.common_tags,
    var.vpc_peering_tags,
    {
      Name = "${local.resources_name}-default"
    }
  )
}

resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public_routes.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.expense-default[0].id
  vpc_peering_connection_id = aws_vpc_peering_connection.expense-default[count.index].id
}

resource "aws_route" "private_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.private_routes.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.expense-default[0].id
  vpc_peering_connection_id = aws_vpc_peering_connection.expense-default[count.index].id
}

resource "aws_route" "database_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.database_routes.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.expense-default[0].id
  vpc_peering_connection_id = aws_vpc_peering_connection.expense-default[count.index].id
}

resource "aws_route" "default_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = data.aws_route_table.default.route_table_id
  destination_cidr_block    = var.cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.expense-default[0].id
  vpc_peering_connection_id = aws_vpc_peering_connection.expense-default[count.index].id
}
