locals {
  pre_non_prod_domains = ["mail-pre-nonprod.platform.hmcts.net"]
  pre_prod_domains     = ["pre-recorded-evidence.justice.gov.uk"]
}

module "pre" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "pre"
  domains     = var.env == "prod" ? local.pre_prod_domains : local.pre_non_prod_domains
}

module "pre-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.pre.dns_records
  zone_name   = var.env == "prod" ? "pre-recorded-evidence.justice.gov.uk" : "platform.hmcts.net"
}
