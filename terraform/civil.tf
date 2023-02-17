# locals {
#   cv_non_prod_domains = ["mail-civil-nonprod.platform.hmcts.net"]
#   cv_prod_domains     = ["mail-civil-prod.platform.hmcts.net"]
# }

# module "civil" {
#   source      = "./modules/sendgrid"
#   environment = var.environment
#   account     = "civil"
#   domains     = var.environment == "prod" ? local.cv_prod_domains : local.cv_non_prod_domains
# }