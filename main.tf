terraform {
  backend "azurerm" {
    resource_group_name   = "tfstaterg"
    storage_account_name  = "autdemotfstate"
    container_name        = "tfstate"
    key                   = "terraform.tfstate_2"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "57480482-27fc-46a6-8643-ee45484365ec"
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "storage" {
  source              = "./modules/st"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "function" {
  source                    = "./modules/func"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  storage_account_name      = module.storage.storage_account_name
  storage_account_access_key = module.storage.storage_account_access_key
  function_app_name         = "autdemo-functionapp1234"
  service_plan_id           = azurerm_service_plan.plan.id
}

module "monitoring" {
  source              = "./modules/monitoring"
  location            = var.location
  resource_group_name = var.resource_group_name
  log_analytics_workspace_name = "autdemo2-law"
}

resource "azurerm_monitor_diagnostic_setting" "function_diagnostics" {
  name                       = "diag-function"
  target_resource_id         = module.function.function_app_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id

  enabled_log {
    category = "FunctionAppLogs"
    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_diagnostics" {
  name                       = "diag-storage"
  target_resource_id         = module.storage.storage_account_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}
