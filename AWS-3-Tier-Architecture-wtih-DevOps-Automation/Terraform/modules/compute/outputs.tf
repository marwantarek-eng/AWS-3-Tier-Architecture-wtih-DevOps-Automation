output "jump_server_a_public_ip" {
  description = "Public IP of Jump Server AZ1"
  value       = aws_instance.jump_server_a.public_ip
}

output "jump_server_a_id" {
  description = "Instance ID of Jump Server AZ1"
  value       = aws_instance.jump_server_a.id
}

output "jump_server_b_public_ip" {
  description = "Public IP of Jump Server AZ2"
  value       = aws_instance.jump_server_b.public_ip
}

output "jump_server_b_id" {
  description = "Instance ID of Jump Server AZ2"
  value       = aws_instance.jump_server_b.id
}