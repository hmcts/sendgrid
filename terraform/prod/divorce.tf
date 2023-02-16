module "divorce" {
  source      = "../modules"
  environment = var.environment
  account     = "divorce"
  domains     = ["mail-divorce.platform.hmcts.net"]
}