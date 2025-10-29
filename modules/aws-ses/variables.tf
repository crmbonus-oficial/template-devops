variable "domain" {
  description = "Nome do domínio para verificar no SES"
  type        = string
  default     = "crmbonus.com"
}

variable "email" {
  description = "E-mail a ser verificado no SES"
  type        = string
  default     = "ses@crmbonus.com"
}

variable "zone_id" {
  description = "ID da zona DNS no Route 53"
  type        = string
}

