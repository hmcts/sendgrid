module "civil" {
  source      = "../modules"
  environment = var.environment
  account     = "civil"
  domains     = ["mail-civil-prod.platform.hmcts.net"]
}