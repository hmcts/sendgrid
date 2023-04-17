module "pcol" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "pcol"
  # single sender is verified instead of domain
  domains     = []
}
