locals {
  darts_dets_non_prod_domains = ["mail-darts-dets-nonprod.platform.hmcts.net"]
  darts_dets_prod_domains     = ["mail-darts-dets-prod.platform.hmcts.net"]
}

module "darts-dets" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "darts-dets"
  domains     = var.env == "prod" ? local.darts_dets_prod_domains : local.darts_dets_non_prod_domains
}

module "darts-dets-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.darts-dets.dns_records
  zone_name   = "platform.hmcts.net"
}
