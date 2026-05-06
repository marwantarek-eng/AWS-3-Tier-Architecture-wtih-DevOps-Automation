variable "vpc_id" {
  description = "ID of the VPC to create security groups in"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "List of CIDRs allowed to SSH into the Jump Server"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "backend_port" {
  description = "Port number the Backend application listens on"
  type        = number
  default     = 3001
}

variable "db_port" {
  description = "Port number for the database (PostgreSQL)"
  type        = number
  default     = 5432
}
