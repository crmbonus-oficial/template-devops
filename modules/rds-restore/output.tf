output "rds_identifier" {
  description = "Identificador da instância restaurada"
  value       = aws_db_instance.restore.id
}

output "rds_endpoint" {
  description = "Endpoint do banco restaurado"
  value       = aws_db_instance.restore.endpoint
}

output "rds_arn" {
  description = "ARN do RDS restaurado"
  value       = aws_db_instance.restore.arn
}

output "rds_subnet_group_name" {
  description = "Nome do subnet group criado automaticamente"
  value       = aws_db_subnet_group.this.name
}

output "rds_security_group_id" {
  description = "ID do security group criado automaticamente"
  value       = aws_security_group.this.id
}