locals {
  div_non_prod_domains = ["mail-divorce-nonprod.platform.hmcts.net"]
  div_prod_domains     = ["mail-divorce.platform.hmcts.net"]
}

module "divorce" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "divorce"
  domains     = var.environment == "prod" ? local.div_prod_domains : local.div_non_prod_domains
}

module "divorce_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.divorce.dns_records
  zone_name   = "platform.hmcts.net"
}