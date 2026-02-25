resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for ${var.project}"
}

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

    allowed_methods = var.allowed_methods
    cached_methods  = var.cached_methods

    # Políticas opcionais
    cache_policy_id            = var.cache_policy_id != null ? var.cache_policy_id : null
    origin_request_policy_id   = var.origin_request_policy_id != null ? var.origin_request_policy_id : null
    response_headers_policy_id = var.response_headers_policy_id != null ? var.response_headers_policy_id : null
  }



  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.geo_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn != null ? var.certificate_arn : null
    ssl_support_method  = var.certificate_arn != null ? "sni-only" : null
    cloudfront_default_certificate = var.certificate_arn == null
  }

  web_acl_id = var.web_acl_id != null ? var.web_acl_id : null

  tags = var.tags
}
