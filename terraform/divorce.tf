locals {
  di_non_prod_domains = ["mail-divorce-nonprod.platform.hmcts.net"]
  di_prod_domains     = ["mail-divorce.platform.hmcts.net"]
}

module "divorce" {
  source      = "./modules"
  environment = var.environment
  account     = "divorce"
  domains     = var.environment == "prod" ? local.di_prod_domains : local.di_non_prod_domains
}