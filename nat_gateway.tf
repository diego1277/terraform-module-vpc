resource "aws_eip" "this" {
  count = length(var.private_subnets) > 0 ? 1 : 0
  domain   = "vpc"
  
  tags = merge({Name = "${var.name}_elastic_ip"},local.common_tags)
}

resource "aws_nat_gateway" "this" {
  count = length(var.private_subnets) > 0 ? 1 : 0
  allocation_id = element(aws_eip.this[*].id, count.index)
  subnet_id     = element(aws_subnet.public[*].id, count.index)

  tags = merge({Name = "${var.name}_nat_gateway"},local.common_tags)
}
