variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "UK South"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "cdn_endpoint_name" {
  description = "Name of the CDN endpoint"
  type        = string
}

variable "cosmosdb_account_name" {
  description = "Name of the CosmosDB account"
  type        = string
}

# Step 5 APi Infrastructure 
variable "function_storage_name" {
  description = "Storage account name for function app"
  type        = string
}

variable "function_app_name" {
  description = "Name of the function app"
  type        = string
}