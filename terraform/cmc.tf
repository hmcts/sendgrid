# locals {
#   cm_non_prod_domains = ["mail-money-claims-nonprod.platform.hmcts.net"]
#   cm_prod_domains     = ["mail-money-claims-prod.platform.hmcts.net"]
# }

# module "cmc" {
#   source      = "./modules/sendgrid"
#   environment = var.environment
#   account     = "cmc"
#   domains     = var.environment == "prod" ? local.cm_prod_domains : local.cm_non_prod_domains
# }