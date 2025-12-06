output "vpc_id" {
  value = module.networking.vpc_id
}

output "frontend_public_ip" {
  value = module.compute.frontend_public_ip
}


output "backend_public_ip" {
  value = module.compute.backend_public_ip
}

output "rds_endpoint" {
  value = module.database.db_endpoint
}
