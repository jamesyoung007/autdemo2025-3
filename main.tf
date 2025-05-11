terraform {
  backend "azurerm" {
    resource_group_name   = "tfstaterg"
    storage_account_name  = "autdemotfstate"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "57480482-27fc-46a6-8643-ee45484365ec"
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "rg" {
  name     = "AUT-2025-demo"
  location = "Australia East"
}

module "storage" {
  source              = "./modules"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "function" {
  source                 = "./modules"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  storage_account_name   = module.storage.azurerm_storage_account.storage.name
  storage_account_key    = module.storage.azurerm_storage_account.storage.primary_access_key
}
