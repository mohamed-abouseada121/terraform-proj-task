# 1. AMI Data Source - Dynamically finds the latest Ubuntu 22.04 LTS Image
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

# 2. Frontend EC2 Instance - The entry point for users (Uptime Kuma)
resource "aws_instance" "frontend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [var.frontend_sg_id]
  associate_public_ip_address = true
  key_name      = var.key_name
  
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y git
              EOF
              
  tags = { Name = "${var.project_name}-frontend" }
}

# 3. Backend EC2 Instance - The application server (Laravel)
resource "aws_instance" "backend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = var.private_app_subnet_id
  vpc_security_group_ids = [var.backend_sg_id]
  associate_public_ip_address = true
  key_name      = var.key_name
  
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y git
              EOF

  tags = { Name = "${var.project_name}-backend" }
}
