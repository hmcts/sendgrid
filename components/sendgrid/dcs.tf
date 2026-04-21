locals {
  dcs_non_prod_domains = ["mail-dcs-nonprod.platform.hmcts.net", "hmcts.net"]
  dcs_prod_domains     = ["mail-dcs.platform.hmcts.net", "hmcts.net"]
}

module "dcs" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "dcs"
  domains     = var.env == "prod" ? local.dcs_prod_domains : local.dcs_non_prod_domains
  custom_dkim_selector = var.env == "prod" ? "dcs" : "dcn"
}

module "dcs-dns" {
  source      = "../modules/azure_dns"
  dns_records = { for k, v in module.dcs.dns_records : k => v if k != "hmcts.net" }
  zone_name   = "platform.hmcts.net"
}

module "dcs-dns-hmcts" {
  source      = "../modules/azure_dns"
  dns_records = { for k, v in module.dcs.dns_records : k => v if k == "hmcts.net" }
  zone_name   = "hmcts.net"
}

removed {
  from = module.dcs.sendgrid_domain_authentication.domain-authenticate["hmcts.net"]

  lifecycle {
    destroy = false
  }
}