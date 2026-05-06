resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "rds-subnet-group"
  subnet_ids  = [var.db_subnet_a_id, var.db_subnet_b_id]
  description = "Subnet group for the RDS instance"
  tags        = { Name = "RDS-Subnet-Group" }
}

resource "aws_db_instance" "rds_instance" {
  identifier        = var.db_identifier
  allocated_storage = var.db_allocated_storage
  engine            = "postgres"
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  publicly_accessible  = false
  skip_final_snapshot  = true
  multi_az             = var.db_multi_az
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = [var.db_sg_id]

  tags = { Name = "Project-RDS" }
}
