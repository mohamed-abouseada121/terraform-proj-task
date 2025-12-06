variable "project_name" {}
variable "private_db_subnet_ids" {}
variable "db_sg_id" {}
variable "db_username" {}
variable "db_password" {}
variable "allocated_storage" { default = 20 }
variable "instance_class" { default = "db.t3.micro" }
