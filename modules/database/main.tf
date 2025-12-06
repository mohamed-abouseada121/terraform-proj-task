# 1. DB Subnet Group - Defines which subnets the RDS instance can use (Multi-AZ)
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids
  tags = { Name = "${var.project_name}-db-subnet-group" }
}

# 2. RDS MySQL Instance - Managed Database Service
# This is the actual database server.
resource "aws_db_instance" "main" {
  allocated_storage      = var.allocated_storage
  storage_type           = "gp3"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_class
  identifier             = "${var.project_name}-db"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_sg_id]
  skip_final_snapshot    = true
  tags = { Name = "${var.project_name}-rds" }
}
