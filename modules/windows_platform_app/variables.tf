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

# FUNCTION_APP
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
  default     = 10
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
  description = "Attributes to ignore changes on"
  type        = list(string)
}


# RBAC
variable "secret_permissions" {
  description = "List of secret permissions for the Key Vault access policy"
  type        = list(string)
  default     = ["Get", "List"]  # Least privilege principle  
}

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