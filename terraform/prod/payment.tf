module "payment" {
  source      = "../modules"
  environment = var.environment
  account     = "payment"
  domains     = ["mail-payment.platform.hmcts.net"]
}