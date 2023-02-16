module "employment-tribunals" {
  source      = "../modules"
  environment = var.environment
  account     = "employment-tribunals"
  domains     = ["employmenttribunals-nonprod.service.gov.uk"]
}