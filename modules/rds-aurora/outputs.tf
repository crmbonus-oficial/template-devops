output "aurora_cluster_id" {
  value = aws_rds_cluster.this.id
}

output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "aurora_reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}

output "aurora_security_group_id" {
  value = aws_security_group.this.id
}

output "aurora_subnet_group_name" {
  value = aws_db_subnet_group.this.name
}

output "aurora_instance_ids" {
  value = aws_rds_cluster_instance.this[*].id
}

output "aurora_secret_name" {
  value = var.aurora_secret_name
}