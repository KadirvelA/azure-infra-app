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

## Define the Linux App Service Plan
resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "F1"    # Free tier
}

# Define the web app
resource "azurerm_linux_web_app" "webapp" {
  name                  = "${var.web_app_name}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  service_plan_id       = azurerm_service_plan.app_service_plan.id
  https_only            = true

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    minimum_tls_version = "1.2"
    always_on = false
  }

  tags = {
    environment = var.environment
  }
}

output "webapp_url" {
  value = "${azurerm_linux_web_app.webapp.name}.azurewebsites.net"
}
