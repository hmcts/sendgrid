module "db-reporting" {
  source      = "../modules"
  environment = var.environment
  account     = "db-reporting"
  domains     = ["mail-db-reporting-prod.platform.hmcts.net"]
}