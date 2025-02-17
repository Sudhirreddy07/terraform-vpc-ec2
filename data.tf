data "aws_availability_zones" "available" {}

data "aws_ami" "amazon_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
