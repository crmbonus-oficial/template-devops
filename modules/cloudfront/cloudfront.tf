resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = var.comment
  price_class     = var.price_class

  aliases = var.aliases

  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = var.origin_id
    viewer_protocol_policy = var.viewer_protocol_policy

    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods

    dynamic "cache_policy_id" {
      for_each = var.cache_policy_id != null ? [1] : []
      content  = var.cache_policy_id
    }

    dynamic "origin_request_policy_id" {
      for_each = var.origin_request_policy_id != null ? [1] : []
      content  = var.origin_request_policy_id
    }

    dynamic "response_headers_policy_id" {
      for_each = var.response_headers_policy_id != null ? [1] : []
      content  = var.response_headers_policy_id
    }
  }

  dynamic "restrictions" {
    for_each = var.restriction_type != "none" ? [1] : []
    content {
      geo_restriction {
        restriction_type = var.restriction_type
        locations        = var.geo_locations
      }
    }
  }

  dynamic "viewer_certificate" {
    for_each = var.certificate_arn != null ? [1] : []
    content {
      acm_certificate_arn = var.certificate_arn
      ssl_support_method  = "sni-only"
    }
  }

  # WAF opcional
  dynamic "web_acl_id" {
    for_each = var.web_acl_id != null ? [1] : []
    content  = var.web_acl_id
  }

  tags = var.tags
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for ${var.project}"
}
