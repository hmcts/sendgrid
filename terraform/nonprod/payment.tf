module "payment" {
  source      = "../modules"
  environment = var.environment
  account     = "payment"
  domains     = ["mail-payment-nonprod.platform.hmcts.net"]
}