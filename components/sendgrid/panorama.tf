locals {
  panorama_non_prod_domains = ["mail-panorama-nonprod.platform.hmcts.net"]
  panorama_prod_domains     = ["mail-panorama.platform.hmcts.net"]
}

module "panorama" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "panorama"
  domains     = var.env == "prod" ? local.panorama_prod_domains : local.panorama_non_prod_domains
}

module "panorama-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.panorama.dns_records
  zone_name   = "platform.hmcts.net"
}