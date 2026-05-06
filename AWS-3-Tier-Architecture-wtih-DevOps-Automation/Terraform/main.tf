# ==========================================
# Provider
# ==========================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# ==========================================
# Module 1: Networking
# ==========================================
module "networking" {
  source = "./modules/networking"

  aws_region             = var.aws_region
  vpc_name               = var.vpc_name
  vpc_cidr               = var.vpc_cidr
  public_subnet_a_cidr   = var.public_subnet_a_cidr
  public_subnet_b_cidr   = var.public_subnet_b_cidr
  frontend_subnet_a_cidr = var.frontend_subnet_a_cidr
  frontend_subnet_b_cidr = var.frontend_subnet_b_cidr
  backend_subnet_a_cidr  = var.backend_subnet_a_cidr
  backend_subnet_b_cidr  = var.backend_subnet_b_cidr
  db_subnet_a_cidr       = var.db_subnet_a_cidr
  db_subnet_b_cidr       = var.db_subnet_b_cidr
}

# ==========================================
# Module 2: Security Groups
# ==========================================
module "security_groups" {
  source = "./modules/security_groups"

  vpc_id            = module.networking.vpc_id
  ssh_allowed_cidrs = var.ssh_allowed_cidrs
  backend_port      = var.backend_port
}

# ==========================================
# Module 3: Load Balancers
# ==========================================
module "load_balancer" {
  source = "./modules/load_balancer"

  vpc_id              = module.networking.vpc_id
  ext_alb_sg_id       = module.security_groups.ext_alb_sg_id
  int_alb_sg_id       = module.security_groups.int_alb_sg_id
  public_subnet_a_id  = module.networking.public_subnet_a_id
  public_subnet_b_id  = module.networking.public_subnet_b_id
  backend_subnet_a_id = module.networking.backend_subnet_a_id
  backend_subnet_b_id = module.networking.backend_subnet_b_id
  backend_port        = var.backend_port

  frontend_health_check_path = var.frontend_health_check_path
  backend_health_check_path  = var.backend_health_check_path
}

# ==========================================
# Module 4: Compute (EC2 + ASGs)
# ==========================================
module "compute" {
  source = "./modules/compute"

  ami_id          = var.ami_id
  key_name        = var.key_name
  public_key_path = var.public_key_path

  jump_instance_type     = var.jump_instance_type
  frontend_instance_type = var.frontend_instance_type
  backend_instance_type  = var.backend_instance_type

  public_subnet_a_id   = module.networking.public_subnet_a_id
  frontend_subnet_a_id = module.networking.frontend_subnet_a_id
  frontend_subnet_b_id = module.networking.frontend_subnet_b_id
  backend_subnet_a_id  = module.networking.backend_subnet_a_id
  backend_subnet_b_id  = module.networking.backend_subnet_b_id

  jump_sg_id     = module.security_groups.jump_sg_id
  frontend_sg_id = module.security_groups.frontend_sg_id
  backend_sg_id  = module.security_groups.backend_sg_id

  front_tg_arn = module.load_balancer.front_tg_arn
  back_tg_arn  = module.load_balancer.back_tg_arn

  frontend_min_size         = var.frontend_min_size
  frontend_max_size         = var.frontend_max_size
  frontend_desired_capacity = var.frontend_desired_capacity
  backend_min_size          = var.backend_min_size
  backend_max_size          = var.backend_max_size
  backend_desired_capacity  = var.backend_desired_capacity
}

# ==========================================
# Module 5: Database (RDS)
# ==========================================
module "database" {
  source = "./modules/database"

  db_subnet_a_id = module.networking.db_subnet_a_id
  db_subnet_b_id = module.networking.db_subnet_b_id
  db_sg_id       = module.security_groups.db_sg_id

  db_identifier        = var.db_identifier
  db_allocated_storage = var.db_allocated_storage
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_name              = var.db_name
  db_multi_az          = var.db_multi_az

  
  db_username = var.db_username
  db_password = var.db_password
}
