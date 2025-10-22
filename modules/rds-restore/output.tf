output "rds_identifier" {
  value = aws_db_instance.restore.id
}

output "rds_endpoint" {
  value = aws_db_instance.restore.endpoint
}
