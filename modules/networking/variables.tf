variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" { default = "10.0.1.0/24" }
variable "private_app_subnet_cidr" { default = "10.0.2.0/24" }
variable "private_db_subnet_cidr" { default = "10.0.3.0/24" }
variable "private_db_subnet_2_cidr" { default = "10.0.4.0/24" }
variable "az_1" { default = "us-east-1a" }
variable "az_2" { default = "us-east-1b" }
