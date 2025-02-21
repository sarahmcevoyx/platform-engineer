resource "azurerm_storage_account" "func_storage" {
  for_each                          = var.function_configs
  name                              = format("%s%s", var.storage_account_name_prefix, each.key)
  location                          = var.resource_group_location
  resource_group_name               = var.resource_group_name
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  min_tls_version                   = var.min_tls_version
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  tags                              = var.tags
  blob_properties {
    last_access_time_enabled = var.last_access_time_enabled
    delete_retention_policy {
      days = var.delete_retention_days
    }
    container_delete_retention_policy {
      days = var.container_delete_retention_days
    }
  }
}
