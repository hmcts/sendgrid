locals {
  makeaplea_non_prod_domains = ["mail-makeaplea-nonprod.platform.hmcts.net"]
  makeaplea_prod_domains     = ["mail-makeaplea.platform.hmcts.net"]
}

module "makeaplea" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "makeaplea"
  domains     = var.env == "prod" ? local.makeaplea_prod_domains : local.makeaplea_non_prod_domains
}

module "makeaplea-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.makeaplea.dns_records
  zone_name   = "platform.hmcts.net"
}
