provider "azurerm" {
  features {}

  subscription_id = "d0dc0483-2c3d-4970-afe2-abbf90a1580e"
}

# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "my-example-rg"
  location = "westus"
}

# Create the Windows App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "my-example-serviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "B1"
}

# Create the Windows Web App
resource "azurerm_windows_web_app" "webapp" {
  name                = "my-example-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  https_only          = true

  site_config {
    minimum_tls_version = "1.2"
    always_on           = false 

    application_stack {
      node_version = "~18"  
    }
  }
}

# Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                  = azurerm_windows_web_app.webapp.id
  repo_url                = "https://github.com/TomasUrregoGiraloDev/Assignment-7-AzureTerraform"
  branch                  = "main"
  use_manual_integration  = true
  use_mercurial           = false
}