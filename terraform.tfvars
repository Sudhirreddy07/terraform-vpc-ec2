############################################################################################################
#  vpc tfvars
############################################################################################################

vpc_name             = "team-dev-vpc"
tags                 = { "Environment" = "Dev", "Project" = "team-dev-vpc" }
vpc_cidr             = "10.0.0.0/16"
public_subnet_names  = ["dev-public-subnet-01", "dev-public-subnet-02"]
private_subnet_names = ["dev-private-subnet-01", "dev-private-subnet-02"]
# database_subnet_names         = ["dev-database-subnet-01", "dev-database-subnet-02"]
igw_tags                      = { Name = "team-dev-internet-gateway" }
nat_gateway_tags              = { Name = "team-dev-nat-gateway" }
nat_eip_tags                  = { Name = "team-dev-eip" }
public_route_table_tags       = { Name = "team-dev-public-rt" }
private_route_table_tags      = { Name = "team-dev-private-rt" }
database_subnet_group_name    = "team-database-subnet-group"
database_subnet_group_tags    = { Name = "team-dev-database-subnet-group" }
dhcp_options_tags             = { Name = "team-dev-dhcp-options" }
create_database_subnet_group  = true
manage_default_network_acl    = false
manage_default_route_table    = false
manage_default_security_group = true
default_security_group_tags   = { Name = "team-dev-vpc-sg" }
default_security_group_ingress = [
  {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
]
default_security_group_egress = [
  {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1" # All traffic
    cidr_blocks = "0.0.0.0/0"
  }
]



enable_dns_hostnames = true
enable_dns_support   = true

enable_nat_gateway = true
single_nat_gateway = true

enable_vpn_gateway = false

enable_dhcp_options = true

# VPC Flow Logs (Cloudwatch log group and IAM role will be created)
enable_flow_log                           = true
create_flow_log_cloudwatch_log_group      = true
create_flow_log_cloudwatch_iam_role       = true
vpc_flow_log_tags                         = { "Name" = "team-dev-vpc-flow-log" }
flow_log_cloudwatch_log_group_name_prefix = "team-dev-flow-log"
flow_log_cloudwatch_log_group_name_suffix = "cloudwatch-log-group"
flow_log_max_aggregation_interval         = 60

#########################################################################################################################################
# security groups
#########################################################################################################################################

ec2_sg_name     = "ec2_security group"
use_name_prefix = false
sg_description  = "Security group with SSH and HTTP rules"
# Ingress Rules (Allow SSH and HTTP for IPv4)
ingress_cidr_blocks = ["0.0.0.0/0"]
ingress_rules       = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
# ingress_with_cidr_blocks = [
#   {
#     from_port   = "3000"
#     to_port     = "3000"
#     protocol    = "tcp"
#     cidr_blocks = "0.0.0.0/0"
#   }
# ]
# Egress Rules (Allow All Outbound Traffic for IPv4)
egress_cidr_blocks      = ["0.0.0.0/0"]
egress_rules            = ["all-all"]
egress_ipv6_cidr_blocks = []

#########################################################################################################################################
# ec2-instance 
#########################################################################################################################################

ec2_name                    = "team-ec2-instance"
instance_type               = "t3.medium" # used to set core count below
key_name                    = "tf-key-pair"
associate_public_ip_address = true
disable_api_stop            = false
create_iam_instance_profile = true
iam_role_description        = "IAM role for EC2 instance"
iam_role_policies = {
  AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
}
# only one of these can be enabled at a time
hibernation = true
# enclave_options_enabled = true
user_data_replace_on_change = true
enable_volume_tags          = false
root_block_device = [
  {
    encrypted   = true
    volume_type = "gp3"
    throughput  = 200
    volume_size = 20
    tags = {
      Name = "team volume"
    }
  },
]