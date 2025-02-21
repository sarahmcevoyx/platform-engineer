
resource "azurerm_windows_function_app" "new" {
  for_each                    = var.function_configs
  name                        = format("%s%s", var.function_app_name_prefix, each.key)
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  service_plan_id             = azurerm_service_plan.func_service_plan[each.key].id
  storage_account_name        = azurerm_storage_account.func_storage[each.key].name
  storage_account_access_key  = azurerm_storage_account.func_storage[each.key].primary_access_key
  https_only                  = var.https_only
  client_certificate_mode     = var.client_certificate_mode
  tags                        = var.tags
  functions_extension_version = local.functions_extension_version

  site_config {
    ftps_state                      = var.ftps_state
    app_scale_limit                 = var.app_scale_limit
    use_32_bit_worker               = var.use_32_bit_worker
    always_on                       = var.always_on
    minimum_instances               = var.minimum_instances
    maximum_instances               = var.maximum_instances
    application_stack {
      python_version = "3.10" # Python version should be same as the packages and dependencies installed - currently commented out for this assessment as not required
      dotnet_version                = var.dotnet_version
      use_dotnet_isolated_runtime   = var.use_dotnet_isolated_runtime
    }
  }

  app_settings = {
    "AzureWebJobsStorage__accountName"  = azurerm_storage_account.func_storage[each.key].name # required setting for managed identity
    "WEBSITE_RUN_FROM_PACKAGE"          = var.website_run_from_package
    "environmentApplicationConfig"      = var.app_config_uri
  }

  identity {
    type = var.identity_type
  }

  auth_settings {
    enabled             = var.auth_enabled
    default_provider    = var.auth_default_provider
    active_directory {
      client_id         = var.auth_client_id
      issuer            = var.auth_issuer
      allowed_audiences = var.auth_allowed_audiences
  }
  }
}
