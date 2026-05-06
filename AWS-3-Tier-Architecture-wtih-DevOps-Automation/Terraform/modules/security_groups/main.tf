resource "aws_security_group" "jump_sg" {
  name        = "Jump-Server-SG"
  description = "Security group for the Jump/Bastion server"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "Jump-Server-SG" }
}

resource "aws_security_group" "ext_alb_sg" {
  name        = "External-ALB-SG"
  description = "Security group for the External Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "External-ALB-SG" }
}

resource "aws_security_group" "frontend_sg" {
  name        = "Frontend-EC2-SG"
  description = "Security group for Frontend EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP only from External ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ext_alb_sg.id]
  }

  ingress {
    description     = "SSH only from Jump Server"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "Frontend-EC2-SG" }
}

resource "aws_security_group" "int_alb_sg" {
  name        = "Internal-ALB-SG"
  description = "Security group for the Internal Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP only from Frontend EC2"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "Internal-ALB-SG" }
}

resource "aws_security_group" "backend_sg" {
  name        = "Backend-EC2-SG"
  description = "Security group for Backend EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "App port only from Internal ALB"
    from_port       = var.backend_port
    to_port         = var.backend_port
    protocol        = "tcp"
    security_groups = [aws_security_group.int_alb_sg.id]
  }

  ingress {
    description     = "SSH only from Jump Server"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "Backend-EC2-SG" }
}

resource "aws_security_group" "db_sg" {
  name        = "Database-RDS-SG"
  description = "Security group for RDS PostgreSQL instance"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL only from Backend EC2"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  tags = { Name = "Database-RDS-SG" }
}
