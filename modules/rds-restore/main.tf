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

  tags = var.tags
}

resource "aws_db_instance" "restore" {
  identifier              = var.db_identifier
  instance_class          = var.instance_class
  publicly_accessible     = var.publicly_accessible
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.this.id]
  availability_zone       = var.availability_zone
  multi_az                = var.multi_az
  storage_type            = var.storage_type
  allocated_storage       = var.allocated_storage
  snapshot_identifier     = var.snapshot_identifier

  username = var.username
  password = var.password

  skip_final_snapshot      = var.skip_final_snapshot
  delete_automated_backups = true

  tags = var.tags
}

