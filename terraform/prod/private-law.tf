module "private-law" {
  source      = "../modules"
  environment = var.environment
  account     = "private-law"
  domains     = ["mail-prl.platform.hmcts.net"]
}