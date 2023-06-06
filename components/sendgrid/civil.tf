locals {
  civil_non_prod_domains = ["mail-civil-nonprod.platform.hmcts.net"]
  civil_prod_domains     = ["mail-civil-prod.platform.hmcts.net"]
}

module "civil" {
  source      = "../modules/sendgrid"
  environment = var.environment
  account     = "civil"
  domains     = var.environment == "prod" ? local.civil_prod_domains : local.civil_non_prod_domains
}

module "civil-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.civil.dns_records
  zone_name   = "platform.hmcts.net"
}
