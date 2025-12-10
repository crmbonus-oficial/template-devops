output "aurora_cluster_id" {
  value = aws_rds_cluster.this.id
}

output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "aurora_reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}
