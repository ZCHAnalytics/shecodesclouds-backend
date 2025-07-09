# Create the resource group
resource "azurerm_resource_group" "resume_rg" {
  name     = "cloud-resume-rg"
  location = "uksouth"
}