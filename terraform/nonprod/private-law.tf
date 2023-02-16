module "private-law" {
  source      = "../modules"
  environment = var.environment
  account     = "private-law"
  domains     = ["mail-prl-nonprod.aat.platform.hmcts.net", "mail-prl-nonprod.demo.platform.hmcts.net", "mail-prl-nonprod.ithc.platform.hmcts.net", "mail-prl-nonprod.perftest.platform.hmcts.net", "mail-prl-nonprod.preview.platform.hmcts.net"]
}