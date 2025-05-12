resource "azurerm_storage_account" "storage" {
  name                     = "autdemostorage1234"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
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
