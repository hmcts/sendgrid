module "access-management" {
  source      = "../modules"
  environment = var.environment
  account     = "access-management"
  domains     = ["mail-am.platform.hmcts.net"]
}