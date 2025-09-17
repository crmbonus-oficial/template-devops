variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "acl" {
  description = "ACL do bucket"
  type        = string
  default     = "private"
}

variable "tags" {
  description = "Tags aplicadas ao bucket"
  type        = map(string)
  default     = {}
}

variable "attach_policy" {
  description = "Se deve anexar uma policy customizada"
  type        = bool
  default     = false
}

variable "bucket_policy" {
  description = "Política do bucket em formato JSON"
  type        = string
  default     = ""
}

variable "enable_versioning" {
  description = "Se deve habilitar versionamento no bucket"
  type        = bool
  default     = false
}
