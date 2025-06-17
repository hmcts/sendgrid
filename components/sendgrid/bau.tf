# This config is designated for BAU/Platform Ops use only.

locals {
  panorama_non_prod_domains = ["mail-bau-nonprod.platform.hmcts.net"]
  panorama_prod_domains     = ["mail-bau.platform.hmcts.net"]
}

module "bau" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "bau"
  domains     = var.env == "prod" ? local.panorama_prod_domains : local.panorama_non_prod_domains
}

module "bau-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.bau.dns_records
  zone_name   = "platform.hmcts.net"
}
