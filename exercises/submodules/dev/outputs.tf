output "main_vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "main_vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "main_private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "main_public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}


output "main_nat_gateway_ips" {
  description = "Elastic IPs of NAT Gateways"
  value       = module.vpc.nat_gateway_ips
}

output "instance_id" {
  description = "Instance ID"
  value       = module.aws_instance.instance_id
}