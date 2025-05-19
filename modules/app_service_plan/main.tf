variable "service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "service_plan_sku" {
  description = "SKU for the App Service Plan"
  type        = string
}

variable "create_service_plan" {
  description = "Whether to create the App Service Plan"
  type        = bool
  default     = true
}

resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
  count               = var.create_service_plan ? 1 : 0
}

output "service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = try(azurerm_service_plan.plan[0].id, null)
}

output "service_plan_name" {
  description = "The name of the App Service Plan"
  value       = var.service_plan_name
}

output "service_plan_sku" {
  description = "The SKU of the App Service Plan"
  value       = var.service_plan_sku
}
