resource "azurerm_service_plan" "plan" {
  // If this resource already exists, import it using:
  // terraform import module.function.azurerm_service_plan.plan "/subscriptions/57480482-27fc-46a6-8643-ee45484365ec/resourceGroups/AUT-2025-demo/providers/Microsoft.Web/serverFarms/autdemo-function-plan"
  name                = "autdemo-function-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "function" {
  name                       = "autdemo-functionapp1234"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  site_config {
    application_stack {
      node_version = "18"
    }
  }
}

output "function_app_id" {
  value = azurerm_linux_function_app.function.id
}
