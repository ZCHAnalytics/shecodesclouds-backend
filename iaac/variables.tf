variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "cdn_endpoint_name" {
  description = "Name of the CDN endpoint"
  type        = string
}

variable "frontend_origin_urls" {
  description = "List of allowed frontend origins for CORS"
  type        = list(string)
}

variable "function_storage_name" {
  description = "Name of the storage account for the Function App"
  type        = string
}

variable "function_app_name" {
  description = "Name of the Azure Function App"
  type        = string
}

variable "cosmosdb_account_name" {
  description = "Name of the Cosmos DB account"
  type        = string
}