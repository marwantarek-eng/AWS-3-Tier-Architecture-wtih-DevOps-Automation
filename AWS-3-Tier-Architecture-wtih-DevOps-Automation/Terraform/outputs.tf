
output "External_ALB_DNS" {
  description = "The DNS name of the External Load Balancer"
  value       = module.load_balancer.ext_alb_dns_name
}

output "Internal_ALB_DNS" {
  description = "The DNS name of the Internal Load Balancer"
  value       = module.load_balancer.int_alb_dns_name
}

output "DB_Instance_Address" {
  description = "The Endpoint of the RDS instance"
  value       = module.database.db_instance_address
}

output "Jump_Server_Public_IP" {
  description = "The Public IP of the Jump Server"
  value       = module.compute.jump_server_public_ip
}
