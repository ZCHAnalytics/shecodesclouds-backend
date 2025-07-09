# -----------------------------------------------------------------------------
# Database Outputs
# -----------------------------------------------------------------------------

output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.resume_cosmos.endpoint
  description = "The endpoint of the CosmosDB account"
}

output "cosmosdb_primary_key" {
  value = azurerm_cosmosdb_account.resume_cosmos.primary_key
  sensitive = true
  description = "The primary key of the CosmosDB account"
}

# -----------------------------------------------------------------------------
# API Outputs
# -----------------------------------------------------------------------------

output "function_app_url" {
  value = "https://${azurerm_linux_function_app.resume_function.default_hostname}"
  description = "The URL of the function app"
}

output "function_app_name" {
  value = azurerm_linux_function_app.resume_function.name
  description = "The name of the function app"
}

output "application_insights_key" {
  description = "Application Insights Instrumentation Key"
  value       = azurerm_application_insights.resume_insights.instrumentation_key
  sensitive   = true
}