
resource "azurerm_windows_function_app" "new" {
  for_each                              = var.function_configs
  name                                  = format("%s%s", var.function_app_name_prefix, each.key)
  location                              = var.resource_group_location
  resource_group_name                   = var.resource_group_name
  service_plan_id                       = azurerm_service_plan.func_service_plan[each.key].id
  storage_account_name                  = azurerm_storage_account.func_storage[each.key].name
  storage_account_access_key            = azurerm_storage_account.func_storage[each.key].primary_access_key
  https_only                            = var.https_only
  client_certificate_mode               = var.client_certificate_mode
  client_certificate_enabled            = var.client_certificate_enabled
  builtin_logging_enabled               = true
  public_network_access_enabled         = false
  tags                                  = var.tags
  functions_extension_version           = local.functions_extension_version
  virtual_network_subnet_id             = var.virtual_network_subnet_id
  # daily_memory_time_quota             = var.daily_memory_time_quota
  # storage_key_vault_secret_id         = var.storage_key_vault_secret_id
  # zip_deploy_file                     = var.zip_deploy_file  
  key_vault_reference_identity_id       = var.key_vault_reference_identity_id

  site_config {
    ftps_state                          = var.ftps_state
    app_scale_limit                     = var.app_scale_limit
    use_32_bit_worker                   = var.use_32_bit_worker
    always_on                           = var.always_on
    elastic_instance_minimum            = var.elastic_instance_minimum
    load_balancing_mode                 = var.load_balancing_mode
    remote_debugging_enabled            = var.remote_debugging_enabled
    remote_debugging_version            = var.remote_debugging_version
    runtime_scale_monitoring_enabled    = var.runtime_scale_monitoring_enabled
    vnet_route_all_enabled              = var.vnet_route_all_enabled
    websockets_enabled                  = var.websockets_enabled
    worker_count                        = var.worker_count
    
    application_stack {
      dotnet_version                    = var.dotnet_version
      use_dotnet_isolated_runtime       = var.use_dotnet_isolated_runtime
      java_version                      = var.java_version
      node_version                      = var.node_version
    }

    app_service_logs {
      disk_quota_mb                     = var.disk_quota_mb
      retention_period_days             = var.retention_period_days_logs
    }

    ip_restriction {
      name                              = var.ip_restriction_name
      ip_address                        = var.ip_restriction_address
      action                            = var.ip_restriction_action
    }
  }

  identity {
    type                                = var.identity_type
    # identity_ids                      = var.identity_ids
  }

  app_settings = {
    "AzureWebJobsStorage__accountName"  = azurerm_storage_account.func_storage[each.key].name # required setting for managed identity
    "WEBSITE_RUN_FROM_PACKAGE"          = var.website_run_from_package
    "environmentApplicationConfig"      = var.app_config_uri
  }

  auth_settings {
    enabled                             = var.auth_enabled
    default_provider                    = var.auth_default_provider
    issuer                              = var.auth_issuer
    active_directory {
      client_id                         = var.auth_client_id
      allowed_audiences                 = var.auth_allowed_audiences
      # client_secret                     = var.client_secret
    }
    token_refresh_extension_hours       = var.token_refresh_extension_hours
    token_store_enabled                 = var.token_store_enabled
    unauthenticated_client_action       = var.unauthenticated_client_action
  }

  # backup {
  #   name                                = "example-backup"
  #   storage_account_url                 = # NEED URL, SO COMMENTING THIS BLOCK OUT
  #   schedule {
  #     frequency_interval                = var.frequency_interval
  #     frequency_unit                    = var.frequency_unit
  #     keep_at_least_one_backup          = var.keep_at_least_one_backup
  #     retention_period_days             = var.retention_period_days
  #   }
  # }
}
