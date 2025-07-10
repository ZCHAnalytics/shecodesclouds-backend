terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "zchtfstatestorageacc"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Create the resource group
resource "azurerm_resource_group" "resume_rg" {
  name     = var.resource_group_name
  location = var.location
}


# CosmosDB Account
resource "azurerm_cosmosdb_account" "resume_cosmos" {
  name                = var.cosmosdb_account_name
  location            = azurerm_resource_group.resume_rg.location
  resource_group_name = azurerm_resource_group.resume_rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  capabilities {
    name = "EnableTable"
  }

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.resume_rg.location
    failover_priority = 0
  }

  free_tier_enabled = true  # This enables the free tier!
}

# CosmosDB Table
resource "azurerm_cosmosdb_table" "visitor_counter" {
  name                = "VisitorCounter"
  resource_group_name = azurerm_resource_group.resume_rg.name
  account_name        = azurerm_cosmosdb_account.resume_cosmos.name
}

# Step 5: Convert API infrastructure into Terraform

# Application Insights
resource "azurerm_application_insights" "resume_insights" {
  name                = "resume-app-insights"
  location            = azurerm_resource_group.resume_rg.location
  resource_group_name = azurerm_resource_group.resume_rg.name
  application_type    = "web"
}

# Storage Account for Function App
resource "azurerm_storage_account" "function_storage" {
  name                     = var.function_storage_name
  resource_group_name      = azurerm_resource_group.resume_rg.name
  location                 = azurerm_resource_group.resume_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# App Service Plan (Linux)
resource "azurerm_service_plan" "resume_plan" {
  name                = "resume-function-plan"
  resource_group_name = azurerm_resource_group.resume_rg.name
  location            = azurerm_resource_group.resume_rg.location
  os_type             = "Linux"
  sku_name            = "Y1"  # Consumption plan (free tier)
}

# Function App
resource "azurerm_linux_function_app" "resume_function" {
  name                = var.function_app_name
  resource_group_name = azurerm_resource_group.resume_rg.name
  location            = azurerm_resource_group.resume_rg.location
  
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.resume_plan.id

  site_config {
    application_insights_key = azurerm_application_insights.resume_insights.instrumentation_key
    application_stack {
      python_version          = "3.10"
    }
    cors {
      allowed_origins = var.frontend_origin_urls
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"       = "python"
    "AzureWebJobsStorage"           = azurerm_storage_account.function_storage.primary_connection_string
    "COSMOS_ENDPOINT"               = azurerm_cosmosdb_account.resume_cosmos.endpoint
    "COSMOS_KEY"                    = azurerm_cosmosdb_account.resume_cosmos.primary_key
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.resume_insights.instrumentation_key
  }
}