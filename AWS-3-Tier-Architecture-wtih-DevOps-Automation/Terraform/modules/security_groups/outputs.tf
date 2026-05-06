output "jump_sg_id" {
  description = "ID of the Jump Server Security Group"
  value       = aws_security_group.jump_sg.id
}

output "ext_alb_sg_id" {
  description = "ID of the External ALB Security Group"
  value       = aws_security_group.ext_alb_sg.id
}

output "frontend_sg_id" {
  description = "ID of the Frontend EC2 Security Group"
  value       = aws_security_group.frontend_sg.id
}

output "int_alb_sg_id" {
  description = "ID of the Internal ALB Security Group"
  value       = aws_security_group.int_alb_sg.id
}

output "backend_sg_id" {
  description = "ID of the Backend EC2 Security Group"
  value       = aws_security_group.backend_sg.id
}

output "db_sg_id" {
  description = "ID of the Database Security Group"
  value       = aws_security_group.db_sg.id
}
