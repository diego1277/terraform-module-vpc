resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(random_shuffle.public.result, count.index)
  map_public_ip_on_launch = var.enable_ip_on_launch

  tags = merge({ Name : "${var.name}_public_subnet_${count.index}" }, local.common_public_subnet_tags)
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = element(aws_route_table.public[*].id, count.index)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags   = merge({ Name = "${var.name}_public_rt" }, local.common_tags)
}
