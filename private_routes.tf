resource "aws_route" "private_nat_gateway" {
  count                  = length(var.private_subnets) > 0 ? 1 : 0
  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)
  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_peering" {
  for_each = length(var.private_subnets) > 0 && length(var.private_routes_peering) > 0 ? var.private_routes_peering : {}
  route_table_id            = aws_route_table.private[0].id
  destination_cidr_block    = each.value.destination_cidr_block
  vpc_peering_connection_id = each.value.vpc_peering_connection_id
}
