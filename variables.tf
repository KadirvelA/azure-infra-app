variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
}


variable "environments" {
  description = "Map of configurations for each environment"
  type = map(object({
    app_service_plan_name = string
    web_app_name          = string
    environment           = string
    location              = string
  }))
  default = {
    dev = {
      app_service_plan_name = "demo-test-splan-dev"
      web_app_name          = "demo-test-webapp-dev"
      environment           = "dev"
      location              = "East US 2"
    },
    qa = {
      app_service_plan_name = "demo-test-splan-qa"
      web_app_name          = "demo-test-webapp-qa"
      environment           = "qa"
      location              = "East US 2"
    },
    prod = {
      app_service_plan_name = "demo-test-splan-prod"
      web_app_name          = "demo-test-webapp-prod"
      environment           = "prod"
      location              = "East US 2"
    }
  }
}


