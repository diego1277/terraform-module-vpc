resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      description = lookup(ingress.value, "description")
      from_port   = lookup(ingress.value, "from_port")
      to_port     = lookup(ingress.value, "to_port")
      protocol    = lookup(ingress.value, "protocol")
      cidr_blocks = lookup(ingress.value, "cidr_blocks",[])
      self        = lookup(ingress.value, "self",false)
      security_groups = lookup(ingress.value, "security_groups",[])
     }
  }

  dynamic "egress" {
    for_each = var.sg_egress_rules 
    content {
      description = lookup(egress.value, "description")
      from_port   = lookup(egress.value, "from_port")
      to_port     = lookup(egress.value, "to_port")
      protocol    = lookup(egress.value, "protocol")
      cidr_blocks = lookup(egress.value, "cidr_blocks",[])
      self        = lookup(egress.value, "self",false)
      security_groups = lookup(egress.value, "security_groups",[])
     }
  }
  tags = merge({Name = "${var.name}_default_sg"},var.default_sg_custom_tags) 
}
