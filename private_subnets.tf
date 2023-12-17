resource "aws_subnet" "private" {
  count             = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(random_shuffle.private[0].result, count.index)

  tags = merge({ Name : "${var.name}_private_subnet_${count.index}" }, local.common_private_subnet_tags)
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.private[*].id, count.index)
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags   = merge({ Name = "${var.name}_private_rt" }, local.common_tags)
}
