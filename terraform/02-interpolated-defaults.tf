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
    default = {
      ips = []
    }
  }
}

locals {
  accounts = { for key, value in var.accounts :
    key => merge(local.sendgrid_config.default, value)
  }
}