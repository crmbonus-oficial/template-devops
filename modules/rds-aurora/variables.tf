variable "aurora_cluster_name" {
  description = "Nome do cluster Aurora"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde o Aurora será implantado"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs das subnets para o Aurora"
  type        = list(string)
}

variable "min_capacity" {
  description = "Capacidade mínima do Aurora Serverless v2"
  type        = number
  default = 1
}

variable "max_capacity" {
  description = "Capacidade máxima do Aurora Serverless v2"
  type        = number
default = 3
}

variable "engine" {
  description = "Engine do Aurora (aurora-mysql ou aurora-postgresql)"
  type        = string
  default     = "aurora-mysql"
}

variable "engine_version" {
  description = "Versão do engine Aurora"
  type        = string
}

variable "master_username" {
  description = "Usuário master do Aurora"
  type        = string
}

variable "master_password" {
  description = "Senha master do Aurora"
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
  description = "Período de retenção de backup em dias"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Janela preferida para backups"
  type        = string
}

variable "preferred_maintenance_window" {
  description = "Janela preferida para manutenção"
  type        = string
}

variable "environment" {
  description = "Ambiente (ex: prod, homol)"
  type        = string
}

variable "product" {
  description = "Nome do produto"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "Lista de blocos CIDR permitidos para acessar o Aurora"
  type = list(object({
    description = string
    cidr_blocks = string
  }))
  default = []
}

variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos criados"
  type        = map(string)
  default     = {}
}

variable "skip_final_snapshot" {
  description = "Define se o snapshot final deve ser pulado ao destruir o cluster"
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "Nome do snapshot final caso skip_final_snapshot seja false"
  type        = string
  default     = null
}