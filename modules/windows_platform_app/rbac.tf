resource "azurerm_role_assignment" "app_config_data_reader_func" {
  for_each              = { for k, v in var.function_configs : k => v if v.use_app_config } # Only assign if use_app_config is true
  scope                 = var.app_config_id
  role_definition_name  = "App Configuration Data Reader"
  principal_id          = azurerm_windows_function_app.new[each.key].identity[0].principal_id
}

resource "azurerm_key_vault_access_policy" "function" {
  for_each              = { for k, v in var.function_configs : k => v if v.use_key_vault } # Only assign if use_key_vault is true
  key_vault_id          = var.key_vault_id
  tenant_id             = var.tenant_id
  object_id             = azurerm_windows_function_app.new[each.key].identity[0].principal_id
  key_permissions       = var.key_permissions 
}

resource "azurerm_role_assignment" "key_vault_crypto_user" {
  for_each              = { for k, v in var.function_configs : k => v if v.use_key_vault } # Only assign if use_key_vault is true
  scope                 = var.key_vault_id
  role_definition_name  = "Key Vault Crypto User"
  principal_id          = azurerm_windows_function_app.new[each.key].identity[0].principal_id
}