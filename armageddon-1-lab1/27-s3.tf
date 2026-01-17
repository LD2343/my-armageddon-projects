
# Random suffix to make bucket name unique (highly recommended)
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 bucket for ALB access logs
resource "aws_s3_bucket" "bos_alb_logs" {
  bucket = "bos-alb-logs-891377135193-${random_string.bucket_suffix.result}"

  force_destroy = true  # optional for lab cleanup
}

# Ownership controls (required for ALB logs)
resource "aws_s3_bucket_ownership_controls" "bos_alb_logs" {
  bucket = aws_s3_bucket.bos_alb_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}






############################################
# S3 bucket for ALB access logs
############################################

# Explanation: This bucket is bos’s log vault—every visitor to the ALB leaves footprints here.
resource "aws_s3_bucket" "bos_alb_logs_bucket01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = "${var.project_name}-alb-logs-${data.aws_caller_identity.bos_self01.account_id}"

  tags = {
    Name = "${var.project_name}-alb-logs-bucket01"
  }
}

# Explanation: Block public access—bos does not publish the ship’s black box to the galaxy.
resource "aws_s3_bucket_public_access_block" "bos_alb_logs_pab01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket                  = aws_s3_bucket.bos_alb_logs_bucket01[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# # Explanation: Bucket ownership controls prevent log delivery chaos—bos likes clean chain-of-custody.
resource "aws_s3_bucket_ownership_controls" "bos_alb_logs_owner01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = aws_s3_bucket.bos_alb_logs_bucket01[0].id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# # Explanation: TLS-only—bos growls at plaintext and throws it out an airlock.
resource "aws_s3_bucket_policy" "bos_alb_logs_policy01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = aws_s3_bucket.bos_alb_logs_bucket01[0].id

  # NOTE: This is a skeleton. Students may need to adjust for region/account specifics.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.bos_alb_logs_bucket01[0].arn,
          "${aws_s3_bucket.bos_alb_logs_bucket01[0].arn}/*"
        ]
        Condition = {
          Bool = { "aws:SecureTransport" = "false" }
        }
      },
      {
        Sid    = "AllowELBPutObject"
        Effect = "Allow"
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.bos_alb_logs_bucket01[0].arn}/${var.alb_access_logs_prefix}/AWSLogs/${data.aws_caller_identity.bos_self01.account_id}/*"
      }
    ]
  })
}

############################################
# Option 2: S3 destination (direct)
############################################

# Explanation: S3 WAF logs are the long-term archive—bos likes receipts that survive dashboards.
resource "aws_s3_bucket" "bos_waf_logs_bucket01" {
  count = var.waf_log_destination == "s3" ? 1 : 0

  bucket = "aws-waf-logs-${var.project_name}-${data.aws_caller_identity.bos_self01.account_id}"

  tags = {
    Name = "${var.project_name}-waf-logs-bucket01"
  }
}

# Explanation: Public access blocked—WAF logs are not a bedtime story for the entire internet.
resource "aws_s3_bucket_public_access_block" "bos_waf_logs_pab01" {
  count = var.waf_log_destination == "s3" ? 1 : 0

  bucket                  = aws_s3_bucket.bos_waf_logs_bucket01[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}