module "ec2_security_group" {
  source          = "terraform-aws-modules/security-group/aws"
  version         = "5.1.0"
  use_name_prefix = var.use_name_prefix
  name            = "${local.name}-security-group"
  description     = var.sg_description
  vpc_id          = module.vpc.vpc_id
  # Ingress Rules (Allow SSH and HTTP for IPv4)
  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_rules       = var.ingress_rules
  #   ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  # Egress Rules (Allow All Outbound Traffic for IPv4)
  egress_cidr_blocks      = var.egress_cidr_blocks
  egress_rules            = var.egress_rules
  egress_ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks
  tags                    = var.tags
  depends_on              = [module.vpc]
}
