# Verifica o domínio crmbonus.com no SES
resource "aws_ses_domain_identity" "domain_identity" {
  domain = var.domain
}


# Verifica o e-mail ses@crmbonus.com no SES
# O SES enviará um e-mail de verificação para esse endereço
resource "aws_ses_email_identity" "email_identity" {
  email = var.email
}

# # Cria registros DNS TXT no Route53 para verificar o domínio
# resource "aws_route53_record" "ses_verification_record" {
#   zone_id = var.zone_id
#   name    = "_amazonses.${var.domain}"
#   type    = "TXT"
#   ttl     = 300
#   records = [aws_ses_domain_identity.domain_identity.verification_token]
# }

# Configura o DKIM (assinatura de e-mails) para o domínio
resource "aws_ses_domain_dkim" "domain_dkim" {
  domain = var.domain
}

# Registros CNAME para DKIM no Route53
resource "aws_route53_record" "ses_dkim_record_1" {
  zone_id = var.zone_id
  name    = "${aws_ses_domain_dkim.domain_dkim.dkim_tokens[0]}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = ["${aws_ses_domain_dkim.domain_dkim.dkim_tokens[0]}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_dkim_record_2" {
  zone_id = var.zone_id
  name    = "${aws_ses_domain_dkim.domain_dkim.dkim_tokens[1]}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = ["${aws_ses_domain_dkim.domain_dkim.dkim_tokens[1]}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_dkim_record_3" {
  zone_id = var.zone_id
  name    = "${aws_ses_domain_dkim.domain_dkim.dkim_tokens[2]}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = ["${aws_ses_domain_dkim.domain_dkim.dkim_tokens[2]}.dkim.amazonses.com"]
}

