resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "private"

  tags = merge(var.tags, {
    Name = var.bucket_name
  })

  dynamic "website" {
    for_each = var.enable_website ? [1] : []
    content {
      index_document = var.index_document
      error_document = var.error_document
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.attach_bucket_policy ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.oai_iam_arn]
    }
  }
}
