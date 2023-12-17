resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge({ Name = "${var.name}_internet_gateway" }, local.common_tags)
}
