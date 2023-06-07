locals {
  nessus_non_prod_domains = ["mail-nessus-nonprod.platform.hmcts.net"]
  nessus_prod_domains     = ["mail-nessus.platform.hmcts.net"]
}

module "nessus" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "nessus"
  domains     = var.env == "prod" ? local.nessus_prod_domains : local.nessus_non_prod_domains
}

module "nessus-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.nessus.dns_records
  zone_name   = "platform.hmcts.net"
}
