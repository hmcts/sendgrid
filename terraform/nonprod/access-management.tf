module "access-management" {
  source      = "../modules"
  environment = var.environment
  account     = "access-management"
  domains     = ["mail-am-nonprod.platform.hmcts.net"]
}