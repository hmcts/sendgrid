locals {
  et_non_prod_domains = ["employmenttribunals-nonprod.service.gov.uk"]
  et_prod_domains     = ["employmenttribunals.service.gov.uk"]
}

module "employment-tribunals" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "employment-tribunals"
  domains     = var.environment == "prod" ? local.et_prod_domains : local.et_non_prod_domains
}

module "employment-tribunals-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.access-management.dns_records
  zone_name   = "tribunalsdecisions.service.gov.uk"
  depends_on = [
    module.employment-tribunals
  ]
}