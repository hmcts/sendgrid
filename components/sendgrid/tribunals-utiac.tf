locals {
  tribunals-utiac_non_prod_domains = ["mail-tribunals-utiac-nonprod.platform.hmcts.net"]
  tribunals-utiac_prod_domains     = ["mail-tribunals-utiac.platform.hmcts.net"]
}

module "tribunals-utiac" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "tribunals-utiac"
  domains     = var.env == "prod" ? local.tribunals-utiac_prod_domains : local.tribunals-utiac_non_prod_domains
}

module "tribunals-utiac-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.tribunals-utiac.dns_records
  zone_name   = "platform.hmcts.net"
}
