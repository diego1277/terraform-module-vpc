data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_shuffle" "private" {
  count        = length(var.private_subnets) > 0 ? 1 : 0
  input        = data.aws_availability_zones.available.names
  result_count = length(var.private_subnets)
}

resource "random_shuffle" "public" {
  input        = data.aws_availability_zones.available.names
  result_count = length(var.public_subnets)
}
