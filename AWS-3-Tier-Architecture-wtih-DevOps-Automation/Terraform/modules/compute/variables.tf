variable "ami_id" {
  description = "AMI ID to use for all EC2 instances"
  type        = string
  default     = "ami-0ed094fb1304fd857"
}

variable "key_name" {
  description = "Name of the SSH Key Pair to create in AWS"
  type        = string
  default     = "MyKey"
}

variable "public_key_path" {
  description = "Path to the local public key file"
  type        = string
  default     = "~/.ssh/MyKey.pub"
}

# --- Instance Types ---
variable "jump_instance_type" {
  description = "Instance type for the Jump Server"
  type        = string
  default     = "t3.micro"
}

variable "frontend_instance_type" {
  description = "Instance type for Frontend EC2 instances"
  type        = string
  default     = "t3.micro"
}

variable "backend_instance_type" {
  description = "Instance type for Backend EC2 instances"
  type        = string
  default     = "t3.micro"
}

# --- Subnet IDs ---
variable "public_subnet_a_id" {
  description = "Public Subnet AZ-a ID (for Jump Server)"
  type        = string
}

variable "frontend_subnet_a_id" {
  description = "Frontend Private Subnet AZ-a ID"
  type        = string
}

variable "frontend_subnet_b_id" {
  description = "Frontend Private Subnet AZ-b ID"
  type        = string
}

variable "backend_subnet_a_id" {
  description = "Backend Private Subnet AZ-a ID"
  type        = string
}

variable "backend_subnet_b_id" {
  description = "Backend Private Subnet AZ-b ID"
  type        = string
}

# --- Security Group IDs ---
variable "jump_sg_id" {
  description = "Security Group ID for the Jump Server"
  type        = string
}

variable "frontend_sg_id" {
  description = "Security Group ID for Frontend EC2 instances"
  type        = string
}

variable "backend_sg_id" {
  description = "Security Group ID for Backend EC2 instances"
  type        = string
}

# --- Target Group ARNs ---
variable "front_tg_arn" {
  description = "ARN of the Frontend Target Group"
  type        = string
}

variable "back_tg_arn" {
  description = "ARN of the Backend Target Group"
  type        = string
}

# --- ASG Sizing ---
variable "frontend_min_size" {
  description = "Minimum number of Frontend instances"
  type        = number
  default     = 1
}

variable "frontend_max_size" {
  description = "Maximum number of Frontend instances"
  type        = number
  default     = 1
}

variable "frontend_desired_capacity" {
  description = "Desired number of Frontend instances"
  type        = number
  default     = 1
}

variable "backend_min_size" {
  description = "Minimum number of Backend instances"
  type        = number
  default     = 1
}

variable "backend_max_size" {
  description = "Maximum number of Backend instances"
  type        = number
  default     = 1
}

variable "backend_desired_capacity" {
  description = "Desired number of Backend instances"
  type        = number
  default     = 1
}
variable "public_subnet_b_id" {
  description = "Public Subnet AZ-b ID (for Jump Server B)"
  type        = string
}