module "reference-data" {
  source      = "../modules"
  environment = var.environment
  account     = "reference-data"
  domains     = ["mail-rd-nonprod.platform.hmcts.net"]
}