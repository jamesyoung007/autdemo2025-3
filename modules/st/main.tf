resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  // If this resource already exists, import it using:
  // terraform import module.storage.azurerm_storage_account.storage "/subscriptions/57480482-27fc-46a6-8643-ee45484365ec/resourceGroups/AUT-2025-demo/providers/Microsoft.Storage/storageAccounts/${var.storage_account_name}"
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}
