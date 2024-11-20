# Define a key pair for the EC2 instance
resource "aws_key_pair" "terra-deployer" {
  key_name   = "terra-deployer-key"
  public_key = file("terra-deployer-key.pub")
}

# default-vpc
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
#subnet
resource "aws_subnet" "default_subnet" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.0.0/16"  # A valid CIDR block within the VPC range
  availability_zone = "ap-south-1a"  # Choose an availability zone in your region
  map_public_ip_on_launch = true       # Enable public IP assignment
  tags = {
    Name = "Default Subnet"
  }
}


# Define a security group for the EC2 instance
resource "aws_security_group" "terra_security_group" {
  name        = "allow_ports"
  description = "Open ports of EC2 instance for inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id #interpolation


  #incoming
  ingress {
    description = "this is for ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #outgoing
  egress {
    description = "this is for outgoing internet request"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name = "mysecurity"
  }
}

# Define an EC2 instance
resource "aws_instance" "my-ec2-instance" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  key_name                = aws_key_pair.terra-deployer.key_name
  subnet_id               = aws_subnet.default_subnet.id

  # Associate security groups
  vpc_security_group_ids  = [aws_security_group.terra_security_group.id] 
  
  tags = {
    Name = "terra-automate"
  }
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
}
