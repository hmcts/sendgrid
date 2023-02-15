module "sendgridmodule" {
    source         = "./modules"
    for_each = { for user in var.accounts : user.name => user }
    environment = var.environment
    account = each.value.name
    domain = each.value.domain
}