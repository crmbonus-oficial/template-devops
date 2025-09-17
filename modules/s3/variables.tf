variable "bucket_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "enable_website" {
  type    = bool
  default = false
}

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "error_document" {
  type    = string
  default = "error.html"
}

variable "attach_bucket_policy" {
  type    = bool
  default = true
}

variable "oai_iam_arn" {
  type    = string
  default = null
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
