module "divorce" {
  source      = "../modules"
  environment = var.environment
  account     = "divorce"
  domains     = ["mail-sscs-nonprod.platform.hmcts.net"]
}