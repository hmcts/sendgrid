module "divorce" {
  source      = "../modules"
  environment = var.environment
  account     = "divorce"
  domain      = "mail-sscs-nonprod.platform.hmcts.net"
}