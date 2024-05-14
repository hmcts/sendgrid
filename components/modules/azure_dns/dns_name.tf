resource "azurerm_dns_cname_record" "record1" {
  for_each            = var.dns_records
  resource_group_name = lower(var.dns_resource_group)
  zone_name           = var.zone_name

  name   = trimsuffix("${lookup(each.value.record1, "host")}", ".${var.zone_name}")
  ttl    = 300
  record = lookup(each.value.record1, "data")
}

resource "azurerm_dns_cname_record" "record2" {
  for_each            = var.dns_records
  resource_group_name = lower(var.dns_resource_group)
  zone_name           = var.zone_name

  name   = trimsuffix("${lookup(each.value.record2, "host")}", ".${var.zone_name}")
  ttl    = 300
  record = lookup(each.value.record2, "data")
}

resource "azurerm_dns_cname_record" "record3" {
  for_each            = var.dns_records
  resource_group_name = lower(var.dns_resource_group)
  zone_name           = var.zone_name

  name   = trimsuffix("${lookup(each.value.record3, "host")}", ".${var.zone_name}")
  ttl    = 300
  record = lookup(each.value.record3, "data")
}
