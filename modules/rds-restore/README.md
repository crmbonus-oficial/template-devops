#########################################
# Módulo: RDS Restore
# Descrição: Restaura uma instância RDS existente a partir de um snapshot
#########################################

resource "aws_db_instance" "restore" {
  identifier              = var.db_identifier
  instance_class          = var.instance_class
  publicly_accessible     = var.publicly_accessible
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  availability_zone       = var.availability_zone
  multi_az                = var.multi_az
  storage_type            = var.storage_type
  allocated_storage       = var.allocated_storage

  # Restauração a partir de snapshot
  snapshot_identifier     = var.snapshot_identifier

  # Credenciais (mesmas do ambiente original)
  username                = var.username
  password                = var.password

  # Configurações de segurança e limpeza
  skip_final_snapshot      = var.skip_final_snapshot
  delete_automated_backups = true

  tags = var.tags
}

#########################################
# Outputs
#########################################

output "rds_identifier" {
  value = aws_db_instance.restore.id
}

output "rds_endpoint" {
  value = aws_db_instance.restore.endpoint
}

output "rds_arn" {
  value = aws_db_instance.restore.arn
}
