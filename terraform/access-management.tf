locals {
  am_non_prod_domains = ["mail-am-nonprod.platform.hmcts.net"]
  am_prod_domains     = ["mail-am.platform.hmcts.net"]
}

module "access-management" {
  source      = "./modules"
  environment = var.environment
  account     = "access-management"
  domains     = var.environment == "prod" ? local.am_prod_domains : local.am_non_prod_domains
}