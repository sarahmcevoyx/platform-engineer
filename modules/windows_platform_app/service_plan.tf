resource "azurerm_service_plan" "func_service_plan" {
  for_each                  = var.function_configs
  name                      = format("%s%s", var.service_plan_name_prefix, each.key)
  location                  = var.resource_group_location
  resource_group_name       = var.resource_group_name
  os_type                   = var.os_type
  sku_name                  = var.ap_sku_name
  worker_count              = var.worker_count
  per_site_scaling_enabled  = var.per_site_scaling_enabled    # set to false for purpose of assignemnt to reduce costs 
  zone_balancing_enabled    = var.zone_balancing_enabled      # set to false for purpose of assignemnt to reduce costs
  tags                      = var.tags
  lifecycle {
    ignore_changes = [
      maximum_elastic_worker_count
    ]
  }
  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
    read   = var.read_timeout
  }
}
