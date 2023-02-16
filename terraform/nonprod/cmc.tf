module "cmc" {
  source      = "../modules"
  environment = var.environment
  account     = "cmc"
  domains     = ["mail-money-claims-nonprod.platform.hmcts.net"]
}