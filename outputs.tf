# Output the resource group location
output "resource_group_name" {
  description = "The name of the resource group location"
  value       = azurerm_resource_group.functions_rg.location
}

# Output the VNet name
output "vnet_name" {
  description = "The name of the vnet"
  value       = azurerm_virtual_network.vnet.name
}

# Output the subnet name
output "subnet_name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.subnet.name
}

# Output the Key Vault ID
output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.functions_kv.id
}

# Output the Key Vault URI (Vault URI)
output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.functions_kv.vault_uri
}

# Output the Log Analytics Workspace name
output "log_analytics_workspace_name" {
  description = "The ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.example.name
}

# Output the Log Analytics Workspace ID
output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.example.id
}

# Output the App Configuration ID
output "app_config_id" {
  description = "The ID of the App Configuration"
  value       = azurerm_app_configuration.functions_appcfg.id
}

# Output the App Configuration endpoint URI
output "app_config_endpoint" {
  description = "The endpoint URI of the App Configuration"
  value       = azurerm_app_configuration.functions_appcfg.endpoint
}

# Output the App Configuration primary readonly connection string
output "app_config_connection_string" {
  description = "The primary readonly connection string for the App Configuration"
  value       = azurerm_app_configuration.functions_appcfg.primary_readonly_connection_string
}
