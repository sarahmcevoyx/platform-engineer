resource "azurerm_storage_account" "func_storage" {
  for_each                         = var.function_configs
  name                             = format("%s%s", var.storage_account_name_prefix, each.key)
  location                         = var.resource_group_location
  resource_group_name              = var.resource_group_name
  account_kind                     = var.account_kind
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  access_tier                      = var.access_tier
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  min_tls_version                  = var.min_tls_version                     # to note - only supported in the Public Cloud
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled    # to note - only supported in the Public Cloud
  https_traffic_only_enabled       = var.https_only
  shared_access_key_enabled        = var.shared_access_key_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  tags                             = var.tags

  blob_properties {
    last_access_time_enabled       = var.last_access_time_enabled
    delete_retention_policy {
      days = var.delete_retention_days
    }
    container_delete_retention_policy {
      days = var.container_delete_retention_days
    }
  }

  queue_properties {
    logging {
      delete                 = var.delete_logging
      read                   = var.read_logging
      write                  = var.write_logging
      version                = var.logging_version
      retention_policy_days  = var.storage_retention_policy_days
    }
  }

  identity {
    type         = var.storage_identity_type
    identity_ids = var.user_assigned_identity_id
  }

  customer_managed_key {
    key_vault_key_id          = var.key_vault_key_id
    managed_hsm_key_id        = var.managed_hsm_key_id
    user_assigned_identity_id = var.storage_identity_type
  }

   timeouts {
    create = var.create_timeout
    read   = var.read_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }

  network_rules {
    default_action             = var.default_action
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
    bypass                     = var.bypass
  }
}
