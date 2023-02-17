# locals {
#   dr_non_prod_domains = ["mail-db-reporting-nonprod.platform.hmcts.net"]
#   dr_prod_domains     = ["mail-db-reporting-prod.platform.hmcts.net"]
# }

# module "db-reporting" {
#   source      = "./modules/sendgrid"
#   environment = var.environment
#   account     = "db-reporting"
#   domains     = var.environment == "prod" ? local.dr_prod_domains : local.dr_non_prod_domains
# }