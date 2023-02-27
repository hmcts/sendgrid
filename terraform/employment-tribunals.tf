locals {
  et_non_prod_domains = ["employmenttribunals-nonprod.service.gov.uk"]
  et_prod_domains     = ["employmenttribunals.service.gov.uk"]
}

module "employment_tribunals" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "employment-tribunals"
  domains     = var.environment == "prod" ? local.et_prod_domains : local.et_non_prod_domains
}

module "employment_tribunals_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.employment_tribunals.dns_records
  zone_name   = "tribunalsdecisions.service.gov.uk"
}