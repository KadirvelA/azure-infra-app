variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
}

variable "location" {
  description = "The location/region of the resource group"
  type        = string
  default     = "westeurope"
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "demo-abp-web-app-plan"
}

variable "web_app_name" {
  description = "The name of the Web App"
  type        = string
  default     = "demo-abp-web-app"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, prod) to dynamically adjust naming and tags."
}