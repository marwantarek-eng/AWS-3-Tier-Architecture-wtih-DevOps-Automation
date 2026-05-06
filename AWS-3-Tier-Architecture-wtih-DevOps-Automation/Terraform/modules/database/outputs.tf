output "db_instance_address" {
  description = "Endpoint address of the RDS instance"
  value       = aws_db_instance.rds_instance.address
}

output "db_instance_port" {
  description = "Port of the RDS instance"
  value       = aws_db_instance.rds_instance.port
}

output "db_instance_id" {
  description = "ID of the RDS instance"
  value       = aws_db_instance.rds_instance.id
}
