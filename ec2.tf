# EC2 Module

module "ec2-instance-public" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  name                        = "${var.ec2_name}-public"
  depends_on                  = [aws_key_pair.tf-key-pair, local_file.tf-key, module.ec2_security_group]
  ami                         = data.aws_ami.amazon_ubuntu.image_id
  instance_type               = var.instance_type # used to set core count below
  key_name                    = aws_key_pair.tf-key-pair.key_name
  availability_zone           = local.azs[0]
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.ec2_security_group.security_group_id]
  associate_public_ip_address = var.associate_public_ip_address
  disable_api_stop            = var.disable_api_stop
  create_iam_instance_profile = var.create_iam_instance_profile
  iam_role_description        = var.iam_role_description
  iam_role_policies           = var.iam_role_policies
  # only one of these can be enabled at a time
  hibernation = var.hibernation
  # enclave_options_enabled = true
  #   user_data                   = var.user_data
  #   user_data_replace_on_change = var.user_data_replace_on_change
  enable_volume_tags = var.enable_volume_tags
  root_block_device  = var.root_block_device
  tags               = var.tags
}


module "ec2-instance-private" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "${var.ec2_name}-private"
  depends_on             = [module.ec2-instance-public]
  ami                    = data.aws_ami.amazon_ubuntu.image_id
  instance_type          = var.instance_type # used to set core count below
  key_name               = aws_key_pair.tf-key-pair.key_name
  availability_zone      = local.azs[0]
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.ec2_security_group.security_group_id]
  #   associate_public_ip_address = var.associate_public_ip_address
  disable_api_stop            = var.disable_api_stop
  create_iam_instance_profile = var.create_iam_instance_profile
  iam_role_description        = var.iam_role_description
  iam_role_policies           = var.iam_role_policies
  # only one of these can be enabled at a time
  hibernation = var.hibernation
  # enclave_options_enabled = true
  #   user_data                   = var.user_data
  #   user_data_replace_on_change = var.user_data_replace_on_change
  enable_volume_tags = var.enable_volume_tags
  root_block_device  = var.root_block_device
  tags               = var.tags
}

################################################################################
# Supporting Resources
################################################################################


resource "aws_key_pair" "tf-key-pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_name}.pem"
}