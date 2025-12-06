output "vpc_id" { value = aws_vpc.main.id }
output "public_subnet_id" { value = aws_subnet.public.id }
output "private_app_subnet_id" { value = aws_subnet.private_app.id }
output "private_db_subnet_ids" { value = [aws_subnet.private_db.id, aws_subnet.private_db_2.id] }
output "frontend_sg_id" { value = aws_security_group.frontend.id }
output "backend_sg_id" { value = aws_security_group.backend.id }
output "db_sg_id" { value = aws_security_group.db.id }
