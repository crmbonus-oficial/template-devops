resource "random_string" "username" {
  length  = 8
  upper   = false
  special = false
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@!"
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name        = "rds/${var.db_identifier}"
  description = "Credenciais do RDS ${var.db_identifier}"
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id     = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = random_string.username.result
    password = random_password.password.result
  })
}

resource "aws_db_instance" "this" {
  identifier              = var.db_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  multi_az                = var.multi_az
  publicly_accessible     = var.publicly_accessible
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids

  username = random_string.username.result
  password = random_password.password.result

  backup_retention_period = var.backup_retention_period
  delete_automated_backups = true

  tags = var.tags
}

output "rds_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "rds_secret_arn" {
  value = aws_secretsmanager_secret.rds_credentials.arn
}

output "rds_secret_name" {
  value = aws_secretsmanager_secret.rds_credentials.name
}
