resource "azurerm_log_analytics_workspace" "law" {
  name                = "autdemo2-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  // If this resource already exists, import it using:
  // terraform import module.monitoring.azurerm_log_analytics_workspace.law "/subscriptions/57480482-27fc-46a6-8643-ee45484365ec/resourceGroups/AUT-2025-demo/providers/Microsoft.OperationalInsights/workspaces/autdemo-law"
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}
