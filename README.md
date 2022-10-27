# Terraform VPC module

## Requirements
Binary version ```v1.3.2```

## Providers

| Name | Version |
|------|---------|
| aws | 4.33.0 |

## How to
Set default configuration
```
module "vpc" {
   source = "https://github.com/diego1277/terraform-vpc-s3.git"
   name = "my_vpc"
   cidr_block = "192.168.0.0/16"
   public_subnets = ["192.168.1.0/24","192.168.3.0/24"]
}
```
Enable private subnets
```
module "vpc" {
   source = "https://github.com/diego1277/terraform-vpc-s3.git"
   name = "my_vpc"
   cidr_block = "192.168.0.0/16"
   public_subnets = ["192.168.1.0/24","192.168.3.0/24"]
   private_subnets = ["192.168.0.0/24","192.168.2.0/24"]
}
```
Enable SG ingress rules
```
module "vpc" {
   source = "./terraform-modules-aws/vpc"
   name = "my_vpc"
   cidr_block = "192.168.0.0/16"
   private_subnets = ["192.168.0.0/24","192.168.2.0/24"]
   public_subnets = ["192.168.1.0/24","192.168.3.0/24"]
   sg_ingress_rules = {
     ingress_self =  {
       description = "self ingress"
       protocol  = -1
       from_port = 0
       to_port   = 0
       self      = true
     }
     allow_ssh = {
       description = "allow ssh ingress"
       protocol  = "TCP"
       from_port = 22
       to_port   = 22
       cidr_blocks = ["179.222.179.220/32"]
    }
    allow_sg = {
       description = "allow sql ingress"
       protocol  = "TCP"
       from_port = 1433
       to_port   = 1433
       security_groups = ["sg-0fb5879a8d59d52b8"]
    }
  }
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tags | additional tags | `map` | `{}` | no |
| cidr\_block | cidr block | `string` | n/a | yes |
| common\_tags | common tags | `map` | <pre>{<br>  "service": "vpc"<br>}</pre> | no |
| enable\_dns\_hostnames | enable dns hostnames | `bool` | `true` | no |
| enable\_dns\_support | enable dns suport | `bool` | `true` | no |
| enable\_ip\_on\_launch | define if instances launched into the subnet should be assigned a public IP address | `bool` | `false` | no |
| name | vpcs name | `string` | n/a | yes |
| private\_subnet\_tags | additional private subnet tags | `map` | `{}` | no |
| private\_subnets | private subnets | `list(string)` | `[]` | no |
| public\_subnet\_tags | additional public subnet tags | `map` | `{}` | no |
| public\_subnets | public subnets | `list(string)` | n/a | yes |
| sg\_egress\_rules | default egress sg rules | <pre>map(object({description=string,from_port=number,to_port=number,protocol=string,<br>                     cidr_blocks=optional(list(string)),self=optional(bool),security_groups=optional(list(string))<br>  }))</pre> | <pre>{<br>  "egress_default": {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "egress default",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>}</pre> | no |
| sg\_ingress\_rules | default ingress sg rules | <pre>map(object({description=string,from_port=number,to_port=number,protocol=string,<br>                     cidr_blocks=optional(list(string)),self=optional(bool),security_groups=optional(list(string))<br>  }))</pre> | <pre>{<br>  "ingress_self": {<br>    "description": "ingress self",<br>    "from_port": 0,<br>    "protocol": -1,<br>    "self": true,<br>    "to_port": 0<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| subnet\_private\_ids | private subnets id |
| subnet\_public\_ids | public subnets id |
| vpc\_id | vpc id |

## Author:
- `Diego Oliveira`
