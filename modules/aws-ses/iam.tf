resource "aws_iam_policy" "ses_send_email_virginia" {
  name        = "AmazonSesSendEmailVirginia"
  description = "Permite envio de e-mails via SES na região us-east-1 (Virginia)."
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSesSendEmail"
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-1"
          }
        }
      }
    ]
  })
}

# Associa a política ao usuário IAM existente
resource "aws_iam_user_policy_attachment" "attach_ses_send_policy" {
  user       = "ses-smtp-user.20250918-162658" # Nome do user já existente
  policy_arn = aws_iam_policy.ses_send_email_virginia.arn
}