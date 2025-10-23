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
  description = "Tamanho do armazenamento em GB"
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

variable "username" {
  description = "Usuário master do banco restaurado (mesmo da origem)"
  type        = string
}

variable "password" {
  description = "Senha master do banco restaurado (mesma da origem)"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags aplicadas ao RDS, SG e Subnet Group"
  type        = map(string)
  default     = {}
}
