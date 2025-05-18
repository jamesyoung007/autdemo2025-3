resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
  // If this resource already exists, import it using:
  // terraform import module.function.azurerm_service_plan.plan "/subscriptions/57480482-27fc-46a6-8643-ee45484365ec/resourceGroups/AUT-2025-demo/providers/Microsoft.Web/serverFarms/${var.service_plan_name}"
}

resource "azurerm_linux_function_app" "function" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = var.service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  site_config {
    application_stack {
      node_version = var.node_version
    }
  }
  // If this resource already exists, import it using:
  // terraform import module.function.azurerm_linux_function_app.function "/subscriptions/57480482-27fc-46a6-8643-ee45484365ec/resourceGroups/AUT-2025-demo/providers/Microsoft.Web/sites/${var.function_app_name}"
}

output "function_app_id" {
  value = azurerm_linux_function_app.function.id
}
