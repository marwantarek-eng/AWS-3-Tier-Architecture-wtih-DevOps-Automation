variable "db_subnet_a_id" {
  description = "DB Private Subnet AZ-a ID"
  type        = string
}

variable "db_subnet_b_id" {
  description = "DB Private Subnet AZ-b ID"
  type        = string
}

variable "db_sg_id" {
  description = "Security Group ID for the RDS instance"
  type        = string
}

variable "db_identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
  default     = "project-rds"
}

variable "db_allocated_storage" {
  description = "Allocated storage size in GB"
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "15"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
  default     = "projectdb"
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment for the RDS instance"
  type        = bool
  default     = false
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}
