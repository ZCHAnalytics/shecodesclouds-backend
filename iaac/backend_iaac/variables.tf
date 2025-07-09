variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "cloud-resume-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "uksouth"
}

variable "cosmosdb_account_name" {
  description = "Name of the CosmosDB account"
  type        = string
  default     = "zchresume-cosmos"
}

variable "function_storage_name" {
  description = "Name of the function storage account"
  type        = string
  default     = "zchfuncstorage"
}

variable "function_app_name" {
  description = "Name of the function app"
  type        = string
  default     = "zchresume-api"
}