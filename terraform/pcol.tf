module "pcol" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "pcol"
  # pcol uses noreply-pcol@hmcts.net for both NLE and prod
  # 'difficult' to get it to change like the rest of the services that each use a unique domain
  domains              = ["hmcts.net"]
  custom_dkim_selector = var.environment == prod ? "prd" : "pnl"
}

module "pcol-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.pcol.dns_records
  zone_name   = "hmcts.net"
}
