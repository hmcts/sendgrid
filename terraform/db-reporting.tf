locals {
   db_non_prod_domains = ["mail-db-reporting-nonprod.platform.hmcts.net"]
   db_prod_domains     = ["mail-db-reporting-prod.platform.hmcts.net"]
}

module "db_reporting" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "db-reporting"
  domains     = var.environment == "prod" ? local.db_prod_domains : local.db_non_prod_domains
}

module "db_reporting_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.db_reporting.dns_records
  zone_name     = "platform.hmcts.net"
  depends_on = [
    module.db_reporting
  ]
}