variable "function_configs" {
  description = "Function app configurations"
  type = map(object({
    storage_account_name        = string
    service_plan_id             = string
    app_config_uri              = string
    https_only                  = bool
    dotnet_version              = string
    use_dotnet_isolated_runtime = bool
    use_app_config              = bool
    use_key_vault               = bool
    use_secrets                 = bool
    use_keys                    = bool
    scaling_settings            = map(string)
  }))
  default = {}
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
  default     = "uksouth"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "myResourceGroup"
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

# variable "storage_key_vault_secret_id" {
#   description = "The ID of the Key Vault Secret for the storage account."
#   type        = string
# }

variable "key_vault_reference_identity_id" {
  description = "The ID of the managed identity for key vault reference"
  type        = string
}

variable "client_certificate_enabled" {
  description = "Indicates whether client certificates are enabled."
  type        = bool
  default     = true
}

# variable "zip_deploy_file" {
#   description = "The path to the zip file for deployment."
#   type        = string
#   default     =
# }

variable "dotnet_version" {
  description = "Specifies the .NET version to use for the function app."
  type        = string
  default     = "5.0"
}

variable "elastic_instance_minimum" {
  description = "Minimum number of elastic instances for the function app"
  type        = number
  default     = 1 
}

variable "load_balancing_mode" {
  description = "Mode for load balancing in the function app"
  type        = string
  default     = "LeastRequests" 
}

variable "use_dotnet_isolated_runtime" {
  description = "Indicates whether to use the isolated .NET runtime."
  type        = bool
  default     = false
}

variable "remote_debugging_enabled" {
  description = "Enable remote debugging for the function app"
  type        = bool
  default     = true  
}

variable "remote_debugging_version" {
  description = "Version for remote debugging in the function app"
  type        = string
  default     = "VS2022"  
}

variable "runtime_scale_monitoring_enabled" {
  description = "Enable runtime scale monitoring for the function app"
  type        = bool
  default     = true  
}

variable "vnet_route_all_enabled" {
  description = "Enable VNet route all for the function app"
  type        = bool
  default     = true
}

variable "websockets_enabled" {
  description = "Enable WebSockets for the function app"
  type        = bool
  default     = false  
}

variable "java_version" {
  description = "Specifies the Java version to use for the function app."
  type        = string
  default     = "11"
}

variable "node_version" {
  description = "Specifies the Node.js version to use for the function app."
  type        = string
  default     = "14"
}

variable "disk_quota_mb" {
  description = "Disk quota in megabytes for app service logs"
  type        = number
  default     = 256  
}

variable "retention_period_days_logs" {
  description = "Retention period in days for logs"
  type        = number
  default     = 7  
}

variable "virtual_network_subnet_id" {
  description = "List of virtual network subnet IDs"
  type        = string
}

variable "app_config_uri" {
  description = "Application configuration URI"
  type        = string
}

variable "key_name" {
  description = "Key name"
  type        = string
}

variable "key_type" {
  description = "Key type"
  type        = string
}

variable "key_size" {
  description = "Key size"
  type        = number
}

variable "key_opts" {
  description = "Key options"
  type        = list(string)
}

variable "token_refresh_extension_hours" {
  description = "Number of hours to extend the token refresh."
  type        = number
  default     = 7
}

variable "token_store_enabled" {
  description = "Whether the token store is enabled."
  type        = bool
  default     = false
}

variable "unauthenticated_client_action" {
  description = "Action to take for unauthenticated clients."
  type        = string
  default     = "RedirectToLoginPage"
}

variable "frequency_interval" {
  description = "Frequency interval for the schedule."
  type        = number
  default     = 7
}

variable "frequency_unit" {
  description = "Frequency unit for the schedule."
  type        = string
  default     = "Day"
}

variable "keep_at_least_one_backup" {
  description = "Whether to keep at least one backup."
  type        = bool
  default     = false
}

variable "retention_period_days" {
  description = "Retention period in days."
  type        = number
  default     = 7
}

variable "function_app_name_prefix" {
  description = "Prefix for function app names"
  type        = string
  default     = "myfunc"
}

variable "https_only" {
  description = "Whether to enforce HTTPS only"
  type        = bool
  default     = true
}

variable "client_certificate_mode" {
  description = "Client certificate mode"
  type        = string
  default     = "Required"
}

variable "ftps_state" {
  description = "The state of FTPS"
  type        = string
  default     = "Disabled"
}

variable "app_scale_limit" {
  description = "App scale limit"
  type        = number
  default     = 2
}

variable "use_32_bit_worker" {
  description = "Use 32-bit worker process"
  type        = bool
  default     = false
}

variable "always_on" {
  description = "Always on"
  type        = bool
  default     = true
}

variable "minimum_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "maximum_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 5
}

variable "website_run_from_package" {
  description = "Website run from package setting"
  type        = string
  default     = "1"
}

variable "identity_type" {
  description = "Type of identity"
  type        = string
  default     = "SystemAssigned"
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


# STORAGE 
variable "storage_account_name_prefix" {
  description = "Prefix for storage account names"
  type        = string
  default     = "myStorage"
}

variable "account_tier" {
  description = "The storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The storage account replication type"
  type        = string
  default     = "LRS"
}

variable "allow_nested_items_to_be_public" {
  description = "Whether to allow nested items to be public"
  type        = bool
  default     = false
}

variable "min_tls_version" {
  description = "Minimum TLS version"
  type        = string
  default     = "TLS1_2"
}

variable "cross_tenant_replication_enabled" {
  description = "Enable cross-tenant replication"
  type        = bool
  default     = true
}

variable "last_access_time_enabled" {
  description = "Enable last access time tracking"
  type        = bool
  default     = true
}

variable "delete_retention_days" {
  description = "Number of days to retain deleted blobs"
  type        = number
  default     = 5
}

variable "container_delete_retention_days" {
  description = "Number of days to retain deleted containers"
  type        = number
  default     = 5
}

variable "default_action" {
  description = "Default action for network rules"
  type        = string
  default     = "Deny"
}

variable "bypass" {
  description = "Services that can bypass the network rules"
  type        = list(string)
  default     = ["AzureServices", "Logging", "Metrics"]
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
  type        = string
  default     = "StorageV2"
}

variable "access_tier" {
  description = "Defines the access tier for the storage account. Valid options are Hot, Cool, and Premium. Defaults to Hot."
  type        = string
  default     = "Cool"
}

variable "shared_access_key_enabled" {
  description = "Enable or disable Shared Key authorisation for the storage account"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable or disable public network access for the storage account"
  type        = bool
  default     = false
}

variable "default_to_oauth_authentication" {
  description = "Default to AAD authorisation when accessing the Storage Account in the Azure portal"
  type        = bool
  default     = true
}

variable "key_vault_key_id" {
  description = "The ID of the Key Vault Key. Supplying a version-less key ID will enable auto-rotation of this key."
  type        = string
  default     = null
}

variable "managed_hsm_key_id" {
  description = "The ID of the managed HSM Key."
  type        = string
  default     = null
}

variable "storage_identity_type" {
  description = "Specifies the type of Managed Service Identity for the Storage Account. Possible values are SystemAssigned, UserAssigned, or both."
  type        = string
  default     = "UserAssigned"
}

variable "user_assigned_identity_id" {
  description = "User-assigned identity IDs"
  type        = set(string)
  default     = ["UserAssigned"]
}

variable "delete_logging" {
  description = "Indicates whether all delete requests should be logged."
  type        = bool
  default     = true
}

variable "read_logging" {
  description = "Indicates whether all read requests should be logged."
  type        = bool
  default     = true
}

variable "write_logging" {
  description = "Indicates whether all write requests should be logged."
  type        = bool
  default     = true
}

variable "logging_version" {
  description = "The version of storage analytics to configure."
  type        = string
  default     = "1.0"
}

variable "storage_retention_policy_days" {
  description = "Specifies the number of days that logs will be retained."
  type        = number
  default     = 7
}


# SERVICE_PLAN 
variable "service_plan_name_prefix" {
  description = "Prefix for service plan names"
  type        = string
  default     = "myServPlan"
}

variable "os_type" {
  description = "The operating system type for the service plan"
  type        = string
  default     = "Windows"
}

variable "ap_sku_name" {
  description = "The sku of the App Service Plan. Possible values are: Premium = P1v2, P2v2, P3v2, Dynamic = Y1"
  type        = string
  default     = "Y1"
}

variable "ignore_changes" {
  description = "List of attributes to ignore changes on"
  type        = list(string)
  default     = []
}

variable "worker_count" {
  description = "The number of workers (instances) allocated"
  type = number
  default = 1
}

variable "per_site_scaling_enabled" {
  description = "Enable per-site scaling for the App Service Plan"
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = "Enable zone balancing for the App Service Plan"
  type        = bool
  default     = false
}

variable "create_timeout" {
  description = "Timeout duration for creating the resource"
  type        = string
  default     = "10m"
}

variable "update_timeout" {
  description = "Timeout duration for updating the resource"
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "Timeout duration for deleting the resource"
  type        = string
  default     = "10m"
}

variable "read_timeout" {
  description = "Timeout duration for reading the resource"
  type        = string
  default     = "5m"
}



# RBAC
variable "app_config_id" {
  description = "The ID of the App Configuration"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the function app"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
}

variable "key_permissions" {
  description = "The operations allowed by the Key Vault key"
  type        = list(string)
  default     = ["decrypt", "encrypt", "sign", "verify", "wrapKey", "unwrapKey"]
}