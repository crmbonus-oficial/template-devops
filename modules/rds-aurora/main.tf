resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.aurora_cluster_name
  engine                  = var.engine
  engine_version          = var.engine_version
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.this.id]
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  
  scaling_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
    auto_pause   = false
  }

  tags = var.tags
}
