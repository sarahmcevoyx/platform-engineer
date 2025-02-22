variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "myResourceGroup"
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
  default     = "uksouth"
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "myVNet"
}

variable "vnet_address_space" {
  description = "The address space of the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "The name of the Subnet"
  type        = string
  default     = "mySubnet"
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the Subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "service_endpoints" {
  description = "The service endpoints to associate with the Subnet"
  type        = list(string)
  default     = []
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
  default     = "myKeyVault"
}

variable "key_vault_sku" {
  description = "The SKU of the Key Vault"
  type        = string
  default     = "standard"
}

variable "enable_soft_delete" {
  description = "Enable soft delete for the Key Vault"
  type        = bool
  default     = true
}

variable "enable_purge_protection" {
  description = "Enable purge protection for the Key Vault"
  type        = bool
  default     = true
}

variable "key_type" {
  description = "The type of the Key Vault key"
  type        = string
  default     = "RSA"
}

variable "key_size" {
  description = "The size of the Key Vault key"
  type        = number
  default     = 2048
}

variable "key_permissions" {
  description = "The operations allowed by the Key Vault key"
  type        = list(string)
  default     = ["get", "decrypt"]
}

variable "secret_permissions" {
  description = "The secret permissions for the Key Vault access policy"
  type        = list(string)
  default     = ["get", "list"]
}  

variable "network_acls_default_action" {
  description = "The default action for network ACLs"
  type        = string
  default     = "Deny"
}

variable "network_acls_bypass" {
  description = "The services that can bypass the network ACLs"
  type        = string
  default     = "AzureServices"
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace"
  type        = string
  default     = "myLogAnalyticsWorkspace"
}

variable "log_analytics_workspace_sku" {
  description = "The SKU of the Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_analytics_retention_days" {
  description = "The retention period for the Log Analytics Workspace"
  type        = number
  default     = 30
}

variable "enable_key_vault_diagnostics" {
  description = "Enable diagnostics for the Key Vault"
  type        = bool
  default     = false
}

variable "diagnostic_setting_name_suffix" {
  description = "The suffix for the diagnostic setting name"
  type        = string
  default     = "-diagnostics"
}

variable "log_category" {
  description = "The log category for diagnostics"
  type        = string
  default     = "AuditEvent"
}

variable "metric_category" {
  description = "The metric category for diagnostics"
  type        = string
  default     = "AllMetrics"
}

variable "log_retention_days" {
  description = "The retention period for logs"
  type        = number
  default     = 30
}

variable "kv_alert_name" {
  description = "The name of the Key Vault metric alert"
  type        = string
  default     = "KVAlert"
}

variable "kv_alert_description" {
  description = "The description of the Key Vault metric alert"
  type        = string
  default     = "Alert for Key Vault metrics"
}

variable "kv_alert_severity" {
  description = "The severity of the Key Vault metric alert"
  type        = number
  default     = 2
}

variable "kv_alert_window_size" {
  description = "The window size for the Key Vault metric alert"
  type        = string
  default     = "PT5M"
}

variable "kv_alert_evaluation_frequency" {
  description = "The evaluation frequency for the Key Vault metric alert"
  type        = string
  default     = "PT1M"
}

variable "kv_alert_metric_namespace" {
  description = "The metric namespace for the Key Vault metric alert"
  type        = string
  default     = "Microsoft.KeyVault/vaults"
}

variable "kv_alert_metric_name" {
  description = "The metric name for the Key Vault metric alert"
  type        = string
  default     = "ServiceApiHit"
}

variable "kv_alert_aggregation" {
  description = "The aggregation method for the Key Vault metric alert"
  type        = string
  default     = "Total"
}

variable "kv_alert_operator" {
  description = "The operator for the Key Vault metric alert"
  type        = string
  default     = "GreaterThan"
}

variable "kv_alert_threshold" {
  description = "The threshold for the Key Vault metric alert"
  type        = number
  default     = 50
}

variable "app_config_name" {
  description = "The name of the App Configuration instance"
  type        = string
  default     = "myAppConfig"
}

variable "function_app_name_prefix" {
  description = "The prefix for the function app name"
  type        = string
  default     = "myfunc"
}

variable "function_configs" {
  description = "Function app configurations"
  type = map(object({
    storage_account_name        = string
    service_plan_id             = string
    app_config_uri              = string
    https_only                  = bool
    dotnet_version              = string
    use_dotnet_isolated_runtime = bool
    scaling_settings            = map(string)
  }))
  default = {}
}

variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
  default     = ""
}

variable "ap_sku_name" {
  description = "The SKU of the function app"
  type        = string
  default     = "Consumption"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    environment = "test"
    owner       = "DevOps"
    cost_centre = "53426"
  }
}

variable "ip_restriction_name" {
  description = "Name for IP restriction"
  type        = string
  default     = "AllowVNet"
}

variable "ip_restriction_address" {
  description = "IP address for IP restriction"
  type        = string
  default     = "VirtualNetwork"
}

variable "ip_restriction_action" {
  description = "Action for IP restriction"
  type        = string
  default     = "Allow"
}

variable "auth_enabled" {
  description = "Enable or disable authentication"
  type        = bool
  default     = true
}

variable "auth_default_provider" {
  description = "Default authentication provider"
  type        = string
  default     = "AzureActiveDirectory"
}

variable "auth_client_id" {
  description = "The client ID for Azure AD authentication"
  type        = string
}

variable "auth_issuer" {
  description = "The issuer URL for Azure AD authentication"
  type        = string
}

variable "auth_allowed_audiences" {
  description = "List of allowed audiences for Azure AD authentication"
  type        = list(string)
  default     = []
}