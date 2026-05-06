# ==========================================
# SSH Key Pair
# ==========================================
resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = file(pathexpand(var.public_key_path))
}

# ==========================================
# Jump Server (Bastion Host)
# ==========================================
resource "aws_instance" "jump_server_a" {
  ami                         = var.ami_id
  instance_type               = var.jump_instance_type
  subnet_id                   = var.public_subnet_a_id
  key_name                    = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids      = [var.jump_sg_id]
  associate_public_ip_address = true
  tags = { Name = "Jump-Server-AZ1" }
}

resource "aws_instance" "jump_server_b" {
  ami                         = var.ami_id
  instance_type               = var.jump_instance_type
  subnet_id                   = var.public_subnet_b_id
  key_name                    = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids      = [var.jump_sg_id]
  associate_public_ip_address = true
  tags = { Name = "Jump-Server-AZ2" }
}

# ==========================================
# Frontend Auto Scaling Group
# ==========================================
resource "aws_launch_template" "front_lt" {
  name_prefix            = "Frontend-LT-"
  image_id               = var.ami_id
  instance_type          = var.frontend_instance_type
  key_name               = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [var.frontend_sg_id]

  user_data = base64encode("#!/bin/bash\nyum update -y\n")

  tag_specifications {
    resource_type = "instance"
    tags          = { Name = "Frontend-EC2" }
  }
}

resource "aws_autoscaling_group" "front_asg" {
  name                = "Frontend-ASG"
  min_size            = var.frontend_min_size
  max_size            = var.frontend_max_size
  desired_capacity    = var.frontend_desired_capacity
  vpc_zone_identifier = [var.frontend_subnet_a_id, var.frontend_subnet_b_id]
  target_group_arns   = [var.front_tg_arn]

  launch_template {
    id      = aws_launch_template.front_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Frontend-EC2"
    propagate_at_launch = true
  }
}

# ==========================================
# Backend Auto Scaling Group
# ==========================================
resource "aws_launch_template" "back_lt" {
  name_prefix            = "Backend-LT-"
  image_id               = var.ami_id
  instance_type          = var.backend_instance_type
  key_name               = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [var.backend_sg_id]

  user_data = base64encode("#!/bin/bash\nyum update -y\n")

  tag_specifications {
    resource_type = "instance"
    tags          = { Name = "Backend-EC2" }
  }
}

resource "aws_autoscaling_group" "back_asg" {
  name                = "Backend-ASG"
  min_size            = var.backend_min_size
  max_size            = var.backend_max_size
  desired_capacity    = var.backend_desired_capacity
  vpc_zone_identifier = [var.backend_subnet_a_id, var.backend_subnet_b_id]
  target_group_arns   = [var.back_tg_arn]

  launch_template {
    id      = aws_launch_template.back_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Backend-EC2"
    propagate_at_launch = true
  }
}
