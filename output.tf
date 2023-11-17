output "alb_id" {
  value = try(aws_lb.alb.id, "")
}

output "alb_name" {
  value = aws_lb.alb.name
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_443_id" {
  value = aws_lb_listener.alb_443[0].id
}

output "sg_alb" {
  value = [aws_security_group.sg_alb.id]
}
