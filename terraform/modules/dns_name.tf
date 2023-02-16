
resource "azurerm_dns_cname_record" "this" {
  for_each = local.dns_records
  resource_group_name = lower(var.dns_resource_group)
  zone_name           = var.zone_name

  name   = each.value.name
  ttl    = 300
  record = each.value.record
}