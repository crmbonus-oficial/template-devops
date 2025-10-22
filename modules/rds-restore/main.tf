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

 
  snapshot_identifier     = var.snapshot_identifier


  skip_final_snapshot     = var.skip_final_snapshot
  delete_automated_backups = true


  username = random_string.username.result
  password = random_password.password.result

  tags = var.tags
}
