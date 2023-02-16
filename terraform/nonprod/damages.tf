module "damages" {
  source      = "../modules"
  environment = var.environment
  account     = "damages"
  domains     = ["mail-damages-nonprod.platform.hmcts.net"]
}