resource "azurerm_storage_account" "storage" {
  name                     = "autdemostorage1234"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  // If this resource already exists, import it using:
  // terraform import module.storage.azurerm_storage_account.storage "/subscriptions/57480482-27fc-46a6-8643-ee45484365ec/resourceGroups/AUT-2025-demo/providers/Microsoft.Storage/storageAccounts/autdemostorage1234"
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
