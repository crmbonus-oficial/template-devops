resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for ${var.project}"
}

resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = var.comment
  price_class     = var.price_class

  # Aplicar default_root_object apenas se fornecido
  default_root_object = var.default_root_object

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

  # Aplicar custom_error_response apenas se fornecido
  dynamic "custom_error_response" {
    for_each = length(var.custom_error_response) > 0 ? var.custom_error_response : []
    content {
      error_code            = custom_error_response.value.error_code
      response_code         = custom_error_response.value.response_code
      response_page_path    = custom_error_response.value.response_page_path
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
    }
  }

  tags = var.tags
}
