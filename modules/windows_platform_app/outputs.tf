# FUNCTION_APP
output "function_app_ids" {
  description = "IDs of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.id }
}

output "function_app_names" {
  description = "The names of the Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.name }
}

output "function_app_resource_groups" {
  description = "Resource Groups of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.resource_group_name }
}

output "function_app_locations" {
  description = "Locations of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.location }
}

output "function_app_service_plan_ids" {
  description = "Service Plan IDs of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.service_plan_id }
}

output "function_app_storage_account_names" {
  description = "Storage Account Names of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.storage_account_name }
}

output "function_app_client_certificate_modes" {
  description = "Client Certificate Modes of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.client_certificate_mode }
}

output "function_app_tags" {
  description = "Tags of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.tags }
}

output "function_app_site_configs" {
  description = "Site Configurations of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.site_config }
}

output "function_app_app_settings" {
  description = "App Settings of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.app_settings }
}

output "function_app_identity_types" {
  description = "Identity Types of the Azure Function Apps"
  value       = { for k, v in azurerm_windows_function_app.new : k => v.identity[0].type }
}


# RBAC
output "role_assignment_ids" {
  description = "IDs of the Role Assignments for App Configuration Data Reader"
  value       = { for k, v in azurerm_role_assignment.app_config_data_reader_func : k => v.id }
}

output "role_assignment_principal_ids" {
  description = "Principal IDs assigned to the App Configuration Data Reader Role"
  value       = { for k, v in azurerm_role_assignment.app_config_data_reader_func : k => v.principal_id }
}

output "key_vault_access_policy_object_ids" {
  description = "Object IDs of the Key Vault Access Policies"
  value       = { for k, v in azurerm_key_vault_access_policy.function : k => v.object_id }
}

output "key_vault_ids" {
  description = "Key Vault IDs for the Access Policies"
  value       = { for k, v in azurerm_key_vault_access_policy.function : k => v.key_vault_id }
}

output "key_vault_tenant_ids" {
  description = "Tenant IDs for the Key Vault Access Policies"
  value       = { for k, v in azurerm_key_vault_access_policy.function : k => v.tenant_id }
}

output "key_vault_key_name" {
  description = "The name of the Key Vault key"
  value       = azurerm_key_vault_key.example_key.name
}


# STORAGE 
output "storage_account_ids" {
  description = "IDs of the Storage Accounts"
  value       = { for k, v in azurerm_storage_account.func_storage : k => v.id }
}

output "storage_account_names" {
  description = "Names of the Storage Accounts"
  value       = { for k, v in azurerm_storage_account.func_storage : k => v.name }
}

output "storage_account_tiers" {
  description = "Account Tiers of the Storage Accounts"
  value       = { for k, v in azurerm_storage_account.func_storage : k => v.account_tier }
} 

output "storage_account_replication_types" {
  description = "Replication Types of the Storage Accounts"
  value       = { for k, v in azurerm_storage_account.func_storage : k => v.account_replication_type }
}

output "storage_account_allow_nested_items_to_be_public" {
  description = "Allow Nested Items to Be Public Settings"
  value       = { for k, v in azurerm_storage_account.func_storage : k => v.allow_nested_items_to_be_public }
}

output "storage_account_min_tls_versions" {
  description = "Minimum TLS Versions of the Storage Accounts"
  value       = { for k, v in azurerm_storage_account.func_storage : k => v.min_tls_version }
}

output "storage_account_cross_tenant_replication_enabled" {
  description = "Cross Tenant Replication Enabled Settings"
  value       = { for k, v in azurerm_storage_account.func_storage : k => v.cross_tenant_replication_enabled }
}

output "storage_account_blob_properties" {
  description = "Blob Properties of the Storage Accounts"
  value       = { for k, v in azurerm_storage_account.func_storage : k => v.blob_properties }
}


# SERVICE_PLAN
output "service_plan_ids" {
  description = "IDs of the Service Plans"
  value       = { for k, v in azurerm_service_plan.func_service_plan : k => v.id }
}

output "service_plan_names" {
  description = "Names of the Service Plans"
  value       = { for k, v in azurerm_service_plan.func_service_plan : k => v.name }
}

output "service_plan_os_types" {
  description = "OS Types of the Service Plans"
  value       = { for k, v in azurerm_service_plan.func_service_plan : k => v.os_type }
}

output "service_plan_sku_names" {
  description = "SKU Names of the Service Plans"
  value       = { for k, v in azurerm_service_plan.func_service_plan : k => v.sku_name }
}

output "service_plan_lifecycle_ignore_changes" {
  description = "Lifecycle Ignore Changes Settings"
  value       = { for k, v in azurerm_service_plan.func_service_plan : k => v.lifecycle[0].ignore_changes }
}