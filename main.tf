resource "aws_lb" "alb" {
  name               = "${var.env}-${var.project_name}-alb"
  internal           = var.alb_type
  load_balancer_type = "application"
  security_groups    = aws_security_group.sg_alb[*].id
  subnets            = var.subnet_ids
  tags = {
    Name        = "${var.env}-${var.project_name}-alb"
    Environment = "${var.env}"
    Management  = "terraform"
  }
}

resource "aws_lb_listener" "alb_80" {
  count             = var.is_https ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb_443" {
  count             = var.is_https ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Access denied"
      status_code  = "403"
    }
  }
}

# --- ALB Security Group  ---
resource "aws_security_group" "sg_alb" {
  name        = "${var.env}-${var.project_name}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = var.cidr_ingress
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = var.sg_ingress
      self             = null
    },
    {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = var.cidr_ingress
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = var.sg_ingress
      self             = null
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null

    }
  ]

  tags = {
    Name        = "${var.env}-${var.project_name}-alb-sg"
    Environment = "${var.env}"
    Management  = "terraform"
  }
}
