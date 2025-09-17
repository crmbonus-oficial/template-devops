variable "project" { type = string }
variable "comment" { type = string default = "CloudFront Distribution" }
variable "price_class" { type = string default = "PriceClass_200" }

variable "origin_domain_name" { type = string }
variable "origin_id" { type = string }
variable "aliases" { type = list(string) default = [] }

variable "default_root_object" { type = string default = "index.html" }
variable "default_allowed_methods" { type = list(string) default = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"] }
variable "default_cached_methods"  { type = list(string) default = ["GET", "HEAD"] }
variable "default_viewer_protocol_policy" { type = string default = "redirect-to-https" }

variable "default_min_ttl"     { type = number default = 0 }
variable "default_default_ttl" { type = number default = 3600 }
variable "default_max_ttl"     { type = number default = 86400 }

variable "ordered_cache_behaviors" {
  type    = list(object({
    path_pattern           = string
    allowed_methods        = list(string)
    cached_methods         = list(string)
    viewer_protocol_policy = string
    query_string           = optional(bool)
    headers                = optional(list(string))
    min_ttl                = optional(number)
    default_ttl            = optional(number)
    max_ttl                = optional(number)
    compress               = optional(bool)
  }))
  default = []
}

variable "certificate_arn" { type = string default = null }
variable "web_acl_id"      { type = string default = null }

variable "restriction_type" { type = string default = "none" }
variable "geo_locations"    { type = list(string) default = [] }

variable "tags" { type = map(string) default = {} }
