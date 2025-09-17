output "bucket_name" {
  description = "Nome do bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN do bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "Domain name do bucket (usado em CloudFront)"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Domain name regional do bucket (preferível para CloudFront)"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
