output "ses_domain_identity_arn" {
  value       = aws_ses_domain_identity.domain_identity.arn
  description = "ARN da identidade do domínio SES"
}

output "ses_dkim_tokens" {
  value       = aws_ses_domain_dkim.domain_dkim.dkim_tokens
  description = "Tokens DKIM gerados para o domínio"
}

output "ses_verification_token" {
  value       = aws_ses_domain_identity.domain_identity.verification_token
  description = "Token de verificação TXT para o domínio"
}