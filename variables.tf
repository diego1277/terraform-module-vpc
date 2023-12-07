variable name {
  description = "vpcs name"
  type        = string
}
variable cidr_block {
  description = "cidr block"
  type        = string
}
variable enable_dns_hostnames {
  description = "enable dns hostnames"
  type        = bool
  default = true
}
variable enable_dns_support {  
  description = "enable dns suport"
  type        = bool
  default = true
}
variable private_subnets {
  description = "private subnets"
  type        = list(string)
  default = []
}
variable public_subnets {
  description = "public subnets"
  type        = list(string)
}
variable enable_ip_on_launch {
  type        = bool
  default     = false
  description = "define if instances launched into the subnet should be assigned a public IP address"
}
variable common_tags {
  description = "common tags"
  type        = map
  default = {
    service = "vpc"
  } 
}
variable additional_tags {
  description = "additional tags"
  type        = map
  default = {}
}
variable private_subnet_tags {
  description = "additional private subnet tags"
  type        = map
  default = {}
}
variable public_subnet_tags {
  description = "additional public subnet tags"
  type        = map
  default = {}
}

variable sg_ingress_rules {
  description = "default ingress sg rules"
  type = map(object({description=string,from_port=number,to_port=number,protocol=string,
                     cidr_blocks=optional(list(string)),self=optional(bool),security_groups=optional(list(string))
  }))
  default = {
   ingress_self = {
      description = "ingress self"
      protocol  = -1
      self      = true
      from_port = 0
      to_port   = 0
    }
  }
}

variable sg_egress_rules {
  description = "default egress sg rules"
  type = map(object({description=string,from_port=number,to_port=number,protocol=string,
                     cidr_blocks=optional(list(string)),self=optional(bool),security_groups=optional(list(string))
  }))
  default = {
   egress_default = {
      description = "egress default"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
variable default_sg_custom_tag {
  description = "default sg custom tags"
  type        = map
  default = {}
}
default_sg_custom_tag
