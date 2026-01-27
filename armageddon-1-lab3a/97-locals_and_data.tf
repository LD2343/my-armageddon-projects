############################################
# Locals (naming convention: edo-*) (Brotherhood Of Steel)
############################################
locals {
  name_prefix = var.project_name
}

############################################
# Bonus A - Data + Locals
############################################

# Explanation: edo wants to know “who am I in this galaxy?” so ARNs can be scoped properly.
data "aws_caller_identity" "edo_self01" {}

# Explanation: Region matters—hyperspace lanes change per sector.
data "aws_region" "edo_region01" {}

locals {
  # Explanation: Name prefix is the roar that echoes through every tag.
  edo_prefix = var.project_name

  # TODO: Students should lock this down after apply using the real secret ARN from outputs/state
  edo_secret_arn_guess = "arn:aws:secretsmanager:${data.aws_region.edo_region01.region}:${data.aws_caller_identity.edo_self01.account_id}:secret:${local.edo_prefix}/rds/mysql*"
}

############################################
# Bonus B - ALB (Public) -> Target Group (Private EC2) + TLS + WAF + Monitoring
############################################

locals {
  # Explanation: This is the roar address — where the galaxy finds your app.
  edo_fqdn = "${var.app_subdomain}.${var.domain_name}"
}

############################################
# Bonus B - Route53 (Hosted Zone + DNS records + ACM validation + ALIAS to ALB)
############################################

# locals {
#   # Explanation: Chewbacca needs a home planet—Route53 hosted zone is your DNS territory.
#   edo_zone_name = var.domain_name

#   # Explanation: Use either Terraform-managed zone or a pre-existing zone ID (students choose their destiny).
#   # edo_zone_id = var.manage_route53_in_terraform ? aws_route53_zone.edo_zone01[0].zone_id : var.route53_hosted_zone_id
#   edo_zone_id = var.route53_hosted_zone_id
#   # Explanation: This is the app address that will growl at the galaxy (app.chewbacca-growl.com).
#   edo_app_fqdn = "${var.app_subdomain}.${var.domain_name}"
# }

### Data
### Lab 2B
# Explanation: Chewbacca only opens the hangar to CloudFront — everyone else gets the Wookiee roar.
data "aws_ec2_managed_prefix_list" "edo_cf_origin_facing01" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

data "aws_cloudfront_origin_request_policy" "edo_orp_all_viewer01" {
  name = "Managed-AllViewer"
}