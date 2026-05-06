output "ext_alb_dns_name" {
  description = "DNS name of the External ALB"
  value       = aws_lb.ext_alb.dns_name
}

output "int_alb_dns_name" {
  description = "DNS name of the Internal ALB"
  value       = aws_lb.int_alb.dns_name
}

output "front_tg_arn" {
  description = "ARN of the Frontend Target Group"
  value       = aws_lb_target_group.front_tg.arn
}

output "back_tg_arn" {
  description = "ARN of the Backend Target Group"
  value       = aws_lb_target_group.back_tg.arn
}
