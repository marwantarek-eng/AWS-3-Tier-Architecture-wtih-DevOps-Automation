# ==========================================
# External ALB (Public-facing)
# ==========================================
resource "aws_lb" "ext_alb" {
  name               = "External-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ext_alb_sg_id]
  subnets            = [var.public_subnet_a_id, var.public_subnet_b_id]
  tags               = { Name = "External-ALB" }
}

resource "aws_lb_target_group" "front_tg" {
  name     = "Frontend-TG"
  port     = var.frontend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.frontend_health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = { Name = "Frontend-TG" }
}

resource "aws_lb_listener" "ext_listener" {
  load_balancer_arn = aws_lb.ext_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_tg.arn
  }
}

# ==========================================
# Internal ALB (Private - Frontend → Backend)
# ==========================================
resource "aws_lb" "int_alb" {
  name               = "Internal-ALB"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.int_alb_sg_id]
  subnets            = [var.backend_subnet_a_id, var.backend_subnet_b_id]
  tags               = { Name = "Internal-ALB" }
}

resource "aws_lb_target_group" "back_tg" {
  name     = "Backend-TG"
  port     = var.backend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.backend_health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = { Name = "Backend-TG" }
}

resource "aws_lb_listener" "int_listener" {
  load_balancer_arn = aws_lb.int_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back_tg.arn
  }
}
