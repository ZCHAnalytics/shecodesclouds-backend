output "static_website_url" {
  value = azurerm_storage_account.resume_storage.primary_web_endpoint
  description = "The URL of the static website"
}

output "storage_account_name" {
  value = azurerm_storage_account.resume_storage.name
  description = "The name of the storage account"
}
output "cdn_endpoint_url" {
  value = "https://${azurerm_cdn_endpoint.resume_endpoint.name}.azureedge.net"
  description = "The CDN endpoint URL"
}

output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.resume_cosmos.endpoint
  description = "The endpoint of the CosmosDB account"
}

output "cosmosdb_primary_key" {
  value = azurerm_cosmosdb_account.resume_cosmos.primary_key
  sensitive = true
  description = "The primary key of the CosmosDB account"
}

# Step 5 Convert APi infra
output "function_app_url" {
  value = "https://${azurerm_linux_function_app.resume_function.default_hostname}"
  description = "The URL of the function app"
}

output "function_app_name" {
  value = azurerm_linux_function_app.resume_function.name
  description = "The name of the function app"
}