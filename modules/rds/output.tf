output "rds_identifier" {
  value = aws_db_instance.this.id
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
