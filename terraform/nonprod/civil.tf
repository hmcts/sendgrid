module "civil" {
  source      = "../modules"
  environment = var.environment
  account     = "civil"
  domains     = ["mail-civil-nonprod.platform.hmcts.net"]
}