variable "db_identifier" {
  description = "Nome da instância do RDS"
  type        = string
}

variable "engine" {
  description = "Engine do banco (ex: postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "vpc_id" {
  description = "ID da VPC onde o banco será restaurado"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets privadas para o Subnet Group"
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "CIDRs permitidos para conexão ao banco (porta 5432)"
  type        = list(string)
  default     = []
}

variable "engine_version" {
  description = "Versão do engine"
  type        = string
  default     = "15.3"
}

variable "instance_class" {
  description = "Tipo de instância (ex: db.m5.large)"
  type        = string
  default     = "db.m6g.large"
}

variable "allocated_storage" {
  description = "Tamanho em GB"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Tipo de armazenamento (gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "multi_az" {
  description = "Se a instância deve ser Multi-AZ"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Define se o banco é público"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Impede deleção acidental"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Pular snapshot final ao deletar"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Número de dias de retenção do backup"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags aplicadas ao RDS e Secrets"
  type        = map(string)
  default     = {}
}

variable "parameter_group_family" {
  description = "Family do parameter group (ex: postgres17)"
  type        = string
}


