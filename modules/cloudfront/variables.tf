variable "project" {
  type        = string
  description = "Nome do projeto (usado para comentários e OAI)."
}

variable "comment" {
  type        = string
  default     = "CloudFront Distribution"
  description = "Comentário para a distribuição."
}

variable "price_class" {
  type        = string
  default     = "PriceClass_All"
  description = "Classe de preço do CloudFront (ex: PriceClass_100, PriceClass_200, PriceClass_All)."
}

variable "origin_domain_name" {
  type        = string
  description = "Domínio de origem (ex: bucket S3 ou ALB)."
}

variable "origin_id" {
  type        = string
  description = "Identificador único da origem."
}

variable "aliases" {
  type        = list(string)
  default     = []
  description = "Domínios alternativos (CNAMEs) para o CloudFront."
}

variable "viewer_protocol_policy" {
  type        = string
  default     = "redirect-to-https"
  description = "Política de protocolo (allow-all, redirect-to-https, https-only)."
}

variable "allowed_methods" {
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
  description = "Métodos HTTP permitidos no comportamento padrão."
}

variable "cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD"]
  description = "Métodos HTTP que podem ser armazenados em cache."
}

variable "cache_policy_id" {
  type        = string
  default     = null
  description = "ID de uma Cache Policy gerenciada ou customizada."
}

variable "origin_request_policy_id" {
  type        = string
  default     = null
  description = "ID de uma Origin Request Policy gerenciada ou customizada."
}

variable "response_headers_policy_id" {
  type        = string
  default     = null
  description = "ID de uma Response Headers Policy gerenciada ou customizada."
}

variable "certificate_arn" {
  type        = string
  default     = null
  description = "ARN do certificado ACM para HTTPS (necessário se usar domínios customizados)."
}

variable "web_acl_id" {
  type        = string
  default     = null
  description = "ARN do Web ACL (AWS WAF)."
}

variable "restriction_type" {
  type        = string
  default     = "none"
  description = "Tipo de restrição geográfica (none, whitelist ou blacklist)."
}

variable "geo_locations" {
  type        = list(string)
  default     = []
  description = "Lista de códigos de países (ISO 3166-1 alpha-2) permitidos ou bloqueados."
}

variable "default_root_object" {
  type        = string
  default     = null
  description = "Objeto raiz padrão para a distribuição CloudFront (ex: index.html). Se null, não será configurado."
}

variable "custom_error_response" {
  type = list(object({
    error_code            = number
    response_code         = number
    response_page_path    = string
    error_caching_min_ttl = number
  }))
  default     = []
  description = "Configurações de resposta de erro customizada para a distribuição CloudFront. Se vazio, não será configurado."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags aplicadas ao recurso CloudFront."
}
