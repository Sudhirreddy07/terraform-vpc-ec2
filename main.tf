################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name            = var.vpc_name
  cidr            = var.vpc_cidr
  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 4, k + 2)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 4, k)]
  #   database_subnets               = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 4, k + 4)]
  public_subnet_names            = var.public_subnet_names
  private_subnet_names           = var.private_subnet_names
  database_subnet_names          = var.database_subnet_names
  igw_tags                       = var.igw_tags
  nat_gateway_tags               = var.nat_gateway_tags
  nat_eip_tags                   = var.nat_eip_tags
  public_route_table_tags        = var.public_route_table_tags
  private_route_table_tags       = var.private_route_table_tags
  database_subnet_group_name     = var.database_subnet_group_name
  database_subnet_group_tags     = var.database_subnet_group_tags
  dhcp_options_tags              = var.dhcp_options_tags
  create_database_subnet_group   = var.create_database_subnet_group
  manage_default_network_acl     = var.manage_default_network_acl
  manage_default_route_table     = var.manage_default_route_table
  manage_default_security_group  = var.manage_default_security_group
  default_security_group_tags    = var.default_security_group_tags
  default_security_group_ingress = var.default_security_group_ingress
  default_security_group_egress  = var.default_security_group_egress
  enable_dns_hostnames           = var.enable_dns_hostnames
  enable_dns_support             = var.enable_dns_support

  enable_nat_gateway  = var.enable_nat_gateway
  single_nat_gateway  = var.single_nat_gateway
  enable_vpn_gateway  = var.enable_vpn_gateway
  enable_dhcp_options = var.enable_dhcp_options

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                           = var.enable_flow_log
  create_flow_log_cloudwatch_log_group      = var.create_flow_log_cloudwatch_log_group
  create_flow_log_cloudwatch_iam_role       = var.create_flow_log_cloudwatch_iam_role
  vpc_flow_log_tags                         = var.vpc_flow_log_tags
  flow_log_cloudwatch_log_group_name_prefix = var.flow_log_cloudwatch_log_group_name_prefix
  flow_log_cloudwatch_log_group_name_suffix = var.flow_log_cloudwatch_log_group_name_suffix
  flow_log_max_aggregation_interval         = var.flow_log_max_aggregation_interval
  tags                                      = var.tags

}