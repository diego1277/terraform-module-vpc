resource "aws_route" "public_internet_gateway" {
  count                  = length(var.public_subnets) > 0 ? 1 : 0
  route_table_id         = element(aws_route_table.public[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
  timeouts {
    create = "5m"
  }
}

resource "aws_route" "public_peering" {
  for_each                  = length(var.public_subnets) > 0 && length(var.public_routes_peering) > 0 ? var.public_routes_peering : {}
  route_table_id            = aws_route_table.private[0].id
  destination_cidr_block    = each.value.destination_cidr_block
  vpc_peering_connection_id = each.value.vpc_peering_connection_id
}

resource "aws_route" "public_tg" {
  for_each               = length(var.public_subnets) > 0 && length(var.public_routes_tg) > 0 ? var.public_routes_tg : {}
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = each.value.destination_cidr_block
  transit_gateway_id     = each.value.transit_gateway_id
}
