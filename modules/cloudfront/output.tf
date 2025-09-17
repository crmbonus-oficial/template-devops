output "cloudfront_distribution_id" {
  description = "ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.this.id
}

output "cloudfront_domain_name" {
  description = "Domain name da distribuição CloudFront"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_arn" {
  description = "ARN da distribuição CloudFront"
  value       = aws_cloudfront_distribution.this.arn
}

output "oai_iam_arn" {
  description = "ARN do OAI para vincular ao bucket"
  value       = aws_cloudfront_origin_access_identity.this.iam_arn
}
