locals {
  utiac_non_prod_domains = ["mail-utiac-nonprod.platform.hmcts.net"]
  utiac_prod_domains     = ["mail-utiac.platform.hmcts.net"]
}

module "utiac" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "utiac"
  domains     = var.env == "prod" ? local.utiac_prod_domains : local.utiac_non_prod_domains
}

# module "utiac-dns" {
#   source      = "../modules/azure_dns"
#   dns_records = module.utiac.dns_records
#   zone_name   = "platform.hmcts.net"
# }
