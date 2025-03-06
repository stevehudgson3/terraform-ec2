provider "aws" {
  region = "us-east-2" # Change to your preferred region
}

resource "aws_instance" "rocky_linux" {
  ami           = data.aws_ami.rocky.id
  instance_type = "t3.micro" # Change based on your needs
  key_name      = "devops" # Replace with your actual key pair name

  security_groups = [aws_security_group.ssh_access.name]

  tags = {
    Name = "RockyLinux-Server"
  }
}

data "aws_ami" "rocky" {
  most_recent = true
  owners      = ["679593333241"] # Rocky Linux official AWS account ID

  filter {
    name   = "name"
    values = ["Rocky-9-*-x86_64"] # Adjust for version preference (e.g., "Rocky-8-*")
  }
}

resource "aws_security_group" "ssh_access" {
  name        = "rocky_linux_sg"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change this to restrict access (e.g., your IP)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
