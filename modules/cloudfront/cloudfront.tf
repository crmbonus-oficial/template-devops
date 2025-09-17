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

  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods  = var.default_allowed_methods
    cached_methods   = var.default_cached_methods
    target_origin_id = var.origin_id

    viewer_protocol_policy = var.default_viewer_protocol_policy

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = var.default_min_ttl
    default_ttl = var.default_default_ttl
    max_ttl     = var.default_max_ttl
  }

  # Ordered cache behaviors opcionais
  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behaviors
    content {
      path_pattern     = ordered_cache_behavior.value.path_pattern
      allowed_methods  = ordered_cache_behavior.value.allowed_methods
      cached_methods   = ordered_cache_behavior.value.cached_methods
      target_origin_id = var.origin_id

      viewer_protocol_policy = ordered_cache_behavior.value.viewer_protocol_policy

      forwarded_values {
        query_string = lookup(ordered_cache_behavior.value, "query_string", false)
        cookies {
          forward = "none"
        }
        headers = lookup(ordered_cache_behavior.value, "headers", [])
      }

      min_ttl     = lookup(ordered_cache_behavior.value, "min_ttl", 0)
      default_ttl = lookup(ordered_cache_behavior.value, "default_ttl", 3600)
      max_ttl     = lookup(ordered_cache_behavior.value, "max_ttl", 86400)
      compress    = lookup(ordered_cache_behavior.value, "compress", true)
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = var.certificate_arn != null ? "sni-only" : null
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.geo_locations
    }
  }

  web_acl_id = var.web_acl_id

  tags = var.tags
}
