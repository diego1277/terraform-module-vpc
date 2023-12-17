locals {
  common_tags                = merge(var.additional_tags, var.common_tags)
  common_private_subnet_tags = merge(var.additional_tags, var.common_tags, var.private_subnet_tags)
  common_public_subnet_tags  = merge(var.additional_tags, var.common_tags, var.public_subnet_tags)
}
