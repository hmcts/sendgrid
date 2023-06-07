locals {
  damages_non_prod_domains = ["mail-damages-nonprod.platform.hmcts.net"]
  damages_prod_domains     = ["mail-damages.platform.hmcts.net"]
}

module "damages" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "damages"
  domains     = var.env == "prod" ? local.damages_prod_domains : local.damages_non_prod_domains
}

module "damages-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.damages.dns_records
  zone_name   = "platform.hmcts.net"
}