# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
    backend "local" {
    path = "./terraform.tfstate-qa" 
    }
}

provider "azurerm" {
  features {}
}


# Loop to create App Service Plan and Web App for each environment
resource "azurerm_service_plan" "app_service_plan" {
  for_each            = var.environments
  name                = each.value.app_service_plan_name
  location            = each.value.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "F1" # Free tier for testing
}

resource "azurerm_linux_web_app" "webapp" {
  for_each            = var.environments
  name                = each.value.web_app_name
  location            = each.value.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.app_service_plan[each.key].id
  https_only          = true

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    minimum_tls_version = "1.2"
    always_on = false
  }

  tags = each.value.tags
}

output "webapp_urls" {
  value = { for env, app in azurerm_linux_web_app.webapp : env => "${app.name}.azurewebsites.net" }
}