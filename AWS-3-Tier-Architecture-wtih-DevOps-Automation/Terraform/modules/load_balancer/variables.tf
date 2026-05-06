variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "ext_alb_sg_id" {
  description = "Security Group ID for the External ALB"
  type        = string
}

variable "int_alb_sg_id" {
  description = "Security Group ID for the Internal ALB"
  type        = string
}

variable "public_subnet_a_id" {
  description = "Public Subnet AZ-a ID (for External ALB)"
  type        = string
}

variable "public_subnet_b_id" {
  description = "Public Subnet AZ-b ID (for External ALB)"
  type        = string
}

variable "backend_subnet_a_id" {
  description = "Backend Private Subnet AZ-a ID (for Internal ALB)"
  type        = string
}

variable "backend_subnet_b_id" {
  description = "Backend Private Subnet AZ-b ID (for Internal ALB)"
  type        = string
}

variable "frontend_port" {
  description = "Port the Frontend application listens on"
  type        = number
  default     = 80
}

variable "backend_port" {
  description = "Port the Backend application listens on"
  type        = number
  default     = 3001
}

variable "frontend_health_check_path" {
  description = "Health check path for the Frontend Target Group"
  type        = string
  default     = "/"
}

variable "backend_health_check_path" {
  description = "Health check path for the Backend Target Group"
  type        = string
  default     = "/api/notes"
}
