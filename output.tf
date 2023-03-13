output "subnet_private_ids" {
  description = "private subnets id"
  value = aws_subnet.private[*].id
}

output "subnet_public_ids" {
  value       = aws_subnet.public[*].id
  description = "public subnets id"
}

output "vpc_id" {
  description = "vpc id"
  value = aws_vpc.this.id
}

output "default_sg_id" {
  description = "default security group id"
  value = aws_default_security_group.this.id
}

output "private_rt_id" {
  description = "private route table id"
  value = try(aws_route_table.private[0].id,null)
}

output "public_rt_id" {
  description = "public route table id"
  value = try(aws_route_table.public[0].id,null)
}
