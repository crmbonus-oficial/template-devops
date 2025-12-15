variable "aurora_cluster_name" {
  description = "Nome do cluster Aurora"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets para o Aurora"
  type        = list(string)
}

variable "engine" {
  description = "Engine do Aurora (aurora-mysql ou aurora-postgresql)"
  type        = string
}

variable "engine_version" {
  description = "Versão do engine Aurora"
  type        = string
}

variable "master_username" {
  description = "Usuário master"
  type        = string
}

variable "master_password" {
  description = "Senha master"
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
  description = "Dias de retenção de backup"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Janela preferida para backup"
  type        = string
}

variable "preferred_maintenance_window" {
  description = "Janela preferida para manutenção"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "Lista de blocos CIDR permitidos"
  type = list(object({
    description = string
    cidr_blocks = string
  }))
  default = []
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}

# Serverless v2
variable "min_capacity" {
  description = "Capacidade mínima em ACUs"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Capacidade máxima em ACUs"
  type        = number
  default     = 3
}

variable "skip_final_snapshot" {
  description = "Se true, não cria snapshot final ao destruir"
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "Nome do snapshot final caso skip_final_snapshot seja false"
  type        = string
  default     = null
}
