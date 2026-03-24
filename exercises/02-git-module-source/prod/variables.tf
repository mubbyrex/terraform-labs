variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "Terraform Submodules"
}



variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "vpc_private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}

variable "vpc_public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "vpc_single_nat_gateway" {
  description = "Use single NAT Gateway for all AZs"
  type        = bool
  default     = true
}

variable "vpc_enable_flow_log" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = true
}

variable "vpc_flow_log_retention_days" {
  description = "CloudWatch Logs retention days for VPC Flow Logs"
  type        = number
  default     = 30
}

variable "vpc_name" {
  description = "Name tag of the peer VPC"
  type        = string
  default     = "main-vpc"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}