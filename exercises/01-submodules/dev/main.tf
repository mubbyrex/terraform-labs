module "vpc" {
  source = "../../../terraform-modules/aws/aws-vpc-core"

  vpc_name                = local.name
  aws_region              = var.aws_region
  cidr_block              = var.vpc_cidr
  private_subnets         = var.vpc_private_subnets
  public_subnets          = var.vpc_public_subnets
  enable_nat_gateway      = var.vpc_enable_nat_gateway
  single_nat_gateway      = var.vpc_single_nat_gateway
  enable_flow_log         = var.vpc_enable_flow_log
  flow_log_retention_days = var.vpc_flow_log_retention_days

  tags = local.common_tags
}



module "aws_instance" {
  source = "../../../terraform-modules/aws/aws-ec2-core"

  instance_name      = "ec2-server"
  instance_type      = "t3.micro"
  ami_id             = data.aws_ami.ubuntu.id
  subnet_id          = module.vpc.private_subnets[0]
  security_group_ids = [aws_security_group.aws_sg.id]

  root_volume_size       = 30
  root_volume_type       = "gp3"
  root_volume_iops       = 3000
  root_volume_throughput = 125

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      OS          = "Linux"
    }
  )

  enable_monitoring = true
}

resource "aws_security_group" "aws_sg" {
  name        = "example-sg"
  description = "Allow SSH and ICMP from the internet, and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-sg"
  }
}
