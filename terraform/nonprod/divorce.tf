module "divorce" {
  source      = "../modules"
  environment = var.environment
  account     = "divorce"
  domains     = ["mail-divorce-nonprod.platform.hmcts.net"]
}