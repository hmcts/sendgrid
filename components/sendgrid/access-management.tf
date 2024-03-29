locals {
  am_non_prod_domains = ["mail-am-nonprod.platform.hmcts.net"]
  am_prod_domains     = ["mail-am.platform.hmcts.net"]
}

module "access_management" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "access-management"
  domains     = var.env == "prod" ? local.am_prod_domains : local.am_non_prod_domains
}

module "access_management_dns" {
  source      = "../modules/azure_dns"
  dns_records = module.access_management.dns_records
  zone_name   = "platform.hmcts.net"
}
