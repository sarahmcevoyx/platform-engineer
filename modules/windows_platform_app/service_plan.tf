resource "azurerm_service_plan" "func_service_plan" {
  for_each            = var.function_configs
  name                = format("%s%s", var.service_plan_name_prefix, each.key)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.ap_sku_name
  lifecycle {
    ignore_changes    = var.ignore_changes
  }
}
