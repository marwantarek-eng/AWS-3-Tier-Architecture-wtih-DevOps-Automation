# ==========================================
# Provider
# ==========================================
variable "aws_region" {
  description = "AWS region to deploy all resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name to use for authentication"
  type        = string
  default     = "terraform-omar"
}

# ==========================================
# Networking
# ==========================================
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
  type    = string
  default = "192.168.1.0/24"
}

variable "public_subnet_b_cidr" {
  type    = string
  default = "192.168.2.0/24"
}

variable "frontend_subnet_a_cidr" {
  type    = string
  default = "192.168.3.0/24"
}

variable "frontend_subnet_b_cidr" {
  type    = string
  default = "192.168.4.0/24"
}

variable "backend_subnet_a_cidr" {
  type    = string
  default = "192.168.5.0/24"
}

variable "backend_subnet_b_cidr" {
  type    = string
  default = "192.168.6.0/24"
}

variable "db_subnet_a_cidr" {
  type    = string
  default = "192.168.7.0/24"
}

variable "db_subnet_b_cidr" {
  type    = string
  default = "192.168.8.0/24"
}

# ==========================================
# Security Groups
# ==========================================
variable "ssh_allowed_cidrs" {
  description = "CIDRs allowed to SSH to the Jump Server — ضيّقها على IP بتاعك في Production"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "backend_port" {
  description = "Port the Backend app listens on"
  type        = number
  default     = 3001
}

# ==========================================
# Load Balancers
# ==========================================
variable "frontend_health_check_path" {
  type    = string
  default = "/"
}

variable "backend_health_check_path" {
  type    = string
  default = "/api/notes"
}

# ==========================================
# Compute
# ==========================================
variable "ami_id" {
  description = "AMI ID for all EC2 instances"
  type        = string
  default     = "ami-0ed094fb1304fd857"
}

variable "key_name" {
  description = "SSH Key Pair name in AWS"
  type        = string
  default     = "MyKey"
}

variable "public_key_path" {
  description = "Path to your local SSH public key file"
  type        = string
  default     = "~/.ssh/MyKey.pub"
}

variable "jump_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "frontend_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "backend_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "frontend_min_size" {
  type    = number
  default = 1
}

variable "frontend_max_size" {
  type    = number
  default = 2
}

variable "frontend_desired_capacity" {
  type    = number
  default = 2
}

variable "backend_min_size" {
  type    = number
  default = 1
}

variable "backend_max_size" {
  type    = number
  default = 2
}

variable "backend_desired_capacity" {
  type    = number
  default = 2
}

# ==========================================
# Database 
# ==========================================
variable "db_identifier" {
  type    = string
  default = "project-rds"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_engine_version" {
  type    = string
  default = "15"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_name" {
  type    = string
  default = "projectdb"
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "db_username" {
  description = "RDS master username — defined in terraform.tfvars only"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS master password — defined in terraform.tfvars only"
  type        = string
  sensitive   = true
}
