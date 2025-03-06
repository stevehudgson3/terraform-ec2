provider "aws" {
  region = "us-east-2" # Change to your preferred AWS region
}

# Fetch the latest RHEL AMI
data "aws_ami" "rhel" {
  most_recent = true
  owners      = ["309956199498"] # Red Hat's official AWS account ID

  filter {
    name   = "name"
    values = ["RHEL-9*-x86_64*"] # Latest RHEL 9 AMI
  }
}

resource "aws_instance" "rhel_free_tier" {
  ami           = data.aws_ami.rhel.id
  instance_type = "t2.micro" # Free Tier eligible
  key_name      = "devops" # Replace with your key pair name

  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "RHEL-Free-Tier"
  }
}

# Security Group to allow SSH (port 22)
resource "aws_security_group" "ssh_access" {
  name        = "rhel_ssh_sg"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change to restrict access (e.g., your IP)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
