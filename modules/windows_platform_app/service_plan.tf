resource "azurerm_service_plan" "func_service_plan" {
  for_each            = var.function_configs
  name                = format("%s%s", var.service_plan_name_prefix, each.key)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type

  lifecycle {
    ignore_changes = [
      name
    ]
  }

  sku {
    tier = var.service_plan_tier
    size = var.service_plan_sku_name
  }
}
