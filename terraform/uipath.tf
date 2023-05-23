locals {
  uipath_non_prod_domains = ["mail-uipath-nonprod.platform.hmcts.net"]
  uipath_prod_domains     = ["mail-uipath.platform.hmcts.net"]
}

module "uipath" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "uipath"
  email       = "DTSPlatformOperations@justice.gov.uk"
  domains     = var.environment == "prod" ? local.uipath_prod_domains : local.uipath_non_prod_domains
}

module "uipath-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.uipath.dns_records
  zone_name   = "platform.hmcts.net"
}
