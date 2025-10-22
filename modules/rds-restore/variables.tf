variable "db_identifier" {
  description = "Nome da instância restaurada"
  type        = string
}

variable "snapshot_identifier" {
  description = "ARN ou nome do snapshot a ser restaurado"
  type        = string
}

variable "instance_class" {
  description = "Tipo de instância (ex: db.m5.large)"
  type        = string
  default     = "db.m5.large"
}

variable "db_subnet_group_name" {
  description = "Nome do subnet group do RDS"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Lista de SGs a associar"
  type        = list(string)
}

variable "availability_zone" {
  description = "Zona de disponibilidade (ex: us-east-1a)"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Se a instância deve ser Multi-AZ"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "Tipo de armazenamento (gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "allocated_storage" {
  description = "Tamanho em GB (usado se não vier do snapshot)"
  type        = number
  default     = 100
}

variable "publicly_accessible" {
  description = "Define se o banco é público"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Pular snapshot final ao deletar"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags aplicadas ao RDS e ao Secret"
  type        = map(string)
  default     = {}
}
