variable "project" {
  type = string
}

variable "comment" {
  type    = string
  default = "CloudFront Distribution"
}

variable "price_class" {
  type    = string
  default = "PriceClass_All"
}

variable "origin_domain_name" {
  type = string
}

variable "origin_id" {
  type = string
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "viewer_protocol_policy" {
  type    = string
  default = "redirect-to-https"
}

variable "allowed_methods" {
  type    = list(string)
  default = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  type    = list(string)
  default = ["GET", "HEAD"]
}

variable "cache_policy_id" {
  type    = string
  default = null
}

variable "origin_request_policy_id" {
  type    = string
  default = null
}

variable "response_headers_policy_id" {
  type    = string
  default = null
}

variable "certificate_arn" {
  type    = string
  default = null
}

variable "web_acl_id" {
  type    = string
  default = null
}

variable "restriction_type" {
  type    = string
  default = "none"
}

variable "geo_locations" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
