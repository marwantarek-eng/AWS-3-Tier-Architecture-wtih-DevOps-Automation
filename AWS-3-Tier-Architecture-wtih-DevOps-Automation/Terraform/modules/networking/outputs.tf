output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_a_id" {
  description = "ID of Public Subnet AZ-a"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "ID of Public Subnet AZ-b"
  value       = aws_subnet.public_b.id
}

output "frontend_subnet_a_id" {
  description = "ID of Frontend Private Subnet AZ-a"
  value       = aws_subnet.frontend_a.id
}

output "frontend_subnet_b_id" {
  description = "ID of Frontend Private Subnet AZ-b"
  value       = aws_subnet.frontend_b.id
}

output "backend_subnet_a_id" {
  description = "ID of Backend Private Subnet AZ-a"
  value       = aws_subnet.backend_a.id
}

output "backend_subnet_b_id" {
  description = "ID of Backend Private Subnet AZ-b"
  value       = aws_subnet.backend_b.id
}

output "db_subnet_a_id" {
  description = "ID of DB Private Subnet AZ-a"
  value       = aws_subnet.db_a.id
}

output "db_subnet_b_id" {
  description = "ID of DB Private Subnet AZ-b"
  value       = aws_subnet.db_b.id
}
