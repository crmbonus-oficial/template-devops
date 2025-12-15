resource "aws_secretsmanager_secret" "aurora_password" {
  name        = "${var.aurora_cluster_name}-master-password"
  description = "Senha master do cluster Aurora"
}

resource "aws_secretsmanager_secret_version" "aurora_password_version" {
  secret_id     = aws_secretsmanager_secret.aurora_password.id
  secret_string = var.master_password
}
#data "aws_secretsmanager_secret" "aurora_password" {
#  name = var.aurora_secret_name
#}
#data "aws_secretsmanager_secret_version" "aurora_password_version" {
#  secret_id = data.aws_secretsmanager_secret.aurora_password.id
#}

resource "aws_db_subnet_group" "this" {
  name       = "${var.aurora_cluster_name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "this" {
  name        = "${var.aurora_cluster_name}-sg"
  description = "Aurora SG"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_cidr_blocks
    content {
      description = ingress.value.description
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = var.tags
}

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

  # Aurora Serverless v2
  serverlessv2_scaling_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  tags = var.tags
}

# Pelo menos uma instância serverless v2
resource "aws_rds_cluster_instance" "this" {
  count              = 1
  identifier         = "${var.aurora_cluster_name}-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = "db.serverless"
  engine             = var.engine
  publicly_accessible = false
  tags               = var.tags
}
