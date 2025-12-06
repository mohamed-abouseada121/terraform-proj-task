# Root Configuration - Wires together Networking, Compute, and Database modules
module "networking" {
  source = "./modules/networking"

  project_name      = var.project_name
  vpc_cidr          = var.vpc_cidr
  
  # Optional overrides if you want to change defaults
  # public_subnet_cidr = "10.0.1.0/24"
  # ...
}

module "compute" {
  source = "./modules/compute"

  project_name          = var.project_name
  public_subnet_id      = module.networking.public_subnet_id
  private_app_subnet_id = module.networking.private_app_subnet_id
  frontend_sg_id        = module.networking.frontend_sg_id
  backend_sg_id         = module.networking.backend_sg_id
  key_name              = var.ssh_key_name
}

module "database" {
  source = "./modules/database"

  project_name          = var.project_name
  private_db_subnet_ids = module.networking.private_db_subnet_ids
  db_sg_id              = module.networking.db_sg_id
  db_username           = var.db_username
  db_password           = var.db_password
}
