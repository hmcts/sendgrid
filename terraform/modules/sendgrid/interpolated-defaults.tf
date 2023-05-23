locals {
  sendgrid_config = {
    nonprod = {
      key_vault_subscription = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
      ips = [
        "167.89.74.65"
      ]
    }
    prod = {
      key_vault_subscription = "8999dec3-0104-4a27-94ee-6588559729d1"
      ips = [
        "167.89.74.8"
      ]
    }
  }
  common_tags = module.ctags.common_tags
}

variable "custom_dkim_selector" {
  description = "If a custom selector is required e.g. shared domain, this will only work if you have a single domain, 3 letters or numbers max."
  default     = null
}

module "ctags" {
  source       = "github.com/hmcts/terraform-module-common-tags"
  environment  = var.environment
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}
