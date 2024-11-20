# # ec2 instance

# resource "aws_default_vpc" "default" {
#   tags = {
#     Name = "Default VPC"
#   }
# }
# resource "aws_subnet" "default_subnet" {
#   vpc_id            = aws_default_vpc.default.id
#   cidr_block        = "0.0.0.0/0"  # A valid CIDR block within the VPC range
#   availability_zone = "ap-south-1a"  # Choose an availability zone in your region
#   map_public_ip_on_launch = true       # Enable public IP assignment
#   tags = {
#     Name = "Default Subnet"
#   }
# }

resource "aws_instance" "my-ec2-instance" {
  count = var.instance_count
  ami                     = var.ami_id
  instance_type           = var.instance_type
  # key_name                = aws_key_pair.terra-deployer.key_name
  # subnet_id               = var.subnet_id
  # vpc_security_group_ids  = var.security_group_ids
  tags = {
    Name = "${var.my-env}-terra-automate-instance"
  }
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
}
