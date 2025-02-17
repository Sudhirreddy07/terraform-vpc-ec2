variable "region" {
  default = ""
}

variable "vpc_name" {
  default = ""
}

variable "vpc_cidr" {
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "public_subnet_names" {
  type    = list(string)
  default = []
}

variable "private_subnet_names" {
  type    = list(string)
  default = []
}

variable "database_subnet_names" {
  type    = list(string)
  default = []
}

variable "igw_tags" {
  type    = map(string)
  default = {}
}

variable "nat_gateway_tags" {
  type    = map(string)
  default = {}
}

variable "nat_eip_tags" {
  type    = map(string)
  default = {}
}

variable "public_route_table_tags" {
  type    = map(string)
  default = {}
}

variable "private_route_table_tags" {
  type    = map(string)
  default = {}
}

variable "database_subnet_group_name" {
  default = ""
}

variable "database_subnet_group_tags" {
  type    = map(string)
  default = {}
}

variable "dhcp_options_tags" {
  type    = map(string)
  default = {}
}

variable "create_database_subnet_group" {
  default = ""
}

variable "manage_default_network_acl" {
  default = ""
}

variable "manage_default_route_table" {
  default = ""
}

variable "manage_default_security_group" {
  default = ""
}

variable "default_security_group_tags" {
  type    = map(string)
  default = {}
}

variable "default_security_group_ingress" {
  type    = list(map(string))
  default = []
}

variable "default_security_group_egress" {
  type    = list(map(string))
  default = []
}

variable "enable_dns_hostnames" {
  default = ""
}

variable "enable_dns_support" {
  default = ""
}

variable "enable_nat_gateway" {
  default = ""
}

variable "single_nat_gateway" {
  default = ""
}

variable "enable_vpn_gateway" {
  default = ""
}

variable "enable_dhcp_options" {
  default = ""
}

variable "enable_flow_log" {
  default = ""
}

variable "create_flow_log_cloudwatch_log_group" {
  default = ""
}

variable "create_flow_log_cloudwatch_iam_role" {
  default = ""
}

variable "vpc_flow_log_tags" {
  type    = map(string)
  default = {}
}

variable "flow_log_cloudwatch_log_group_name_prefix" {
  default = ""
}

variable "flow_log_cloudwatch_log_group_name_suffix" {
  default = ""
}

variable "flow_log_max_aggregation_interval" {
  default = ""
}

############################################################################################################
# ec2 security group variable
############################################################################################################


variable "use_name_prefix" {
  default = ""
}
variable "ec2_sg_name" { default = "" }
variable "sg_description" { default = "" }
variable "ingress_cidr_blocks" { default = "" }
variable "ingress_rules" { default = "" }
variable "ingress_with_cidr_blocks" { default = "" }
variable "egress_cidr_blocks" { default = "" }
variable "egress_rules" { default = "" }
variable "egress_ipv6_cidr_blocks" { default = "" }

############################################################################################################
# ec2-instance variable
############################################################################################################
variable "ec2_name" {
  type        = string
  default     = "my-ec2-instance"
  description = "Name of the EC2 instance"
}

variable "ami" {
  type        = string
  default     = "ami-12345678"
  description = "AMI ID for the instance"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type for the EC2 instance"
}

variable "availability_zone" {
  type        = string
  default     = "us-east-1a"
  description = "Availability Zone where the instance will be launched"
}

variable "subnet_id" {
  type        = string
  default     = "subnet-abc123"
  description = "Subnet ID where the instance will be placed"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = ["sg-12345678"]
  description = "List of security group IDs for the EC2 instance"
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Whether to associate a public IP address with the instance"
}

variable "disable_api_stop" {
  type        = bool
  default     = false
  description = "If true, the instance cannot be stopped via API calls"
}

variable "create_iam_instance_profile" {
  type        = bool
  default     = false
  description = "Whether to create an IAM instance profile"
}

variable "iam_role_description" {
  type        = string
  default     = "EC2 IAM Role"
  description = "Description of the IAM role associated with the instance"
}

variable "iam_role_policies" {
  default     = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess"]
  description = "List of IAM policies to attach to the role"
}

variable "hibernation" {
  type        = bool
  default     = false
  description = "Enable or disable hibernation for the instance"
}

variable "user_data" {
  type        = string
  default     = ""
  description = "User data script to initialize the instance"
}

variable "user_data_replace_on_change" {
  type        = bool
  default     = false
  description = "If true, user data changes will trigger instance replacement"
}

variable "enable_volume_tags" {
  type        = bool
  default     = true
  description = "Whether to enable volume tagging"
}

variable "root_block_device" {
  default = {
    volume_size = "20"
    volume_type = "gp2"
  }
  description = "Root block device configuration for the instance"
}

variable "key_name" {
  type        = string
  default     = "my-key-pair"
  description = "Key pair name for SSH access to the instance"
}
