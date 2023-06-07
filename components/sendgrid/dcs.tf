locals {
  dcs_non_prod_domains = ["mail-dcs-nonprod.platform.hmcts.net"]
  dcs_prod_domains     = ["mail-dcs.platform.hmcts.net"]
}

module "dcs" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "dcs"
  domains     = var.env == "prod" ? local.dcs_prod_domains : local.dcs_non_prod_domains
}

module "dcs-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.dcs.dns_records
  zone_name   = "platform.hmcts.net"
}

