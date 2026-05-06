variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "Project-3Tier-VPC"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "CIDR for Public Subnet in AZ-a"
  type        = string
  default     = "192.168.1.0/24"
}

variable "public_subnet_b_cidr" {
  description = "CIDR for Public Subnet in AZ-b"
  type        = string
  default     = "192.168.2.0/24"
}

variable "frontend_subnet_a_cidr" {
  description = "CIDR for Frontend Private Subnet in AZ-a"
  type        = string
  default     = "192.168.3.0/24"
}

variable "frontend_subnet_b_cidr" {
  description = "CIDR for Frontend Private Subnet in AZ-b"
  type        = string
  default     = "192.168.4.0/24"
}

variable "backend_subnet_a_cidr" {
  description = "CIDR for Backend Private Subnet in AZ-a"
  type        = string
  default     = "192.168.5.0/24"
}

variable "backend_subnet_b_cidr" {
  description = "CIDR for Backend Private Subnet in AZ-b"
  type        = string
  default     = "192.168.6.0/24"
}

variable "db_subnet_a_cidr" {
  description = "CIDR for DB Private Subnet in AZ-a"
  type        = string
  default     = "192.168.7.0/24"
}

variable "db_subnet_b_cidr" {
  description = "CIDR for DB Private Subnet in AZ-b"
  type        = string
  default     = "192.168.8.0/24"
}
