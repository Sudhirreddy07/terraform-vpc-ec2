locals {
  azs           = slice(data.aws_availability_zones.available.names, 0, 2)
  region        = "eu-west-2"
  name          = "team-github-selfhosted-runner"
  my_ami_name   = "team-instance-ami-image-${formatdate("YYYY-MM-DD-hhmmss", timestamp())}"
  instance_type = "t3.medium"
  tags = {
    Environment = "dev"
    Project     = "team"
    Terraform   = "true"
  }
}
