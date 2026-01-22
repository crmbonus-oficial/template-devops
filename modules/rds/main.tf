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
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = random_string.username.result
    password = random_password.password.result
  })
}

resource "aws_security_group" "this" {
  name        = "${var.db_identifier}-sg"
  description = "Security group para ${var.db_identifier}"
  vpc_id      = var.vpc_id

  ingress {
    description = "Acesso PostgreSQL interno"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    description = "Saida liberada"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_db_subnet_group" "this" {
  name        = "${var.db_identifier}-subnet-group"
  description = "Subnet group para ${var.db_identifier}"
  subnet_ids  = var.subnet_ids
  tags        = var.tags
}

resource "aws_db_instance" "this" {
  identifier          = var.db_identifier
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  storage_type        = var.storage_type
  multi_az            = var.multi_az
  publicly_accessible = var.publicly_accessible

  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  username = random_string.username.result
  password = random_password.password.result

  backup_retention_period  = var.backup_retention_period
  delete_automated_backups = true

  tags = var.tags

  depends_on = [
    aws_db_subnet_group.this,
    aws_security_group.this
  ]
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
