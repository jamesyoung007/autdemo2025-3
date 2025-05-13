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

// If the resource already exists in Azure, import it into the Terraform state file:
// terraform import azurerm_service_plan.plan "/subscriptions/57480482-27fc-46a6-8643-ee45484365ec/resourceGroups/AUT-2025-demo_2/providers/Microsoft.Web/serverFarms/autdemo2-function-plan"

resource "azurerm_service_plan" "plan" {
  name                = "autdemo2-function-plan"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "Y1"
  count               = var.create_service_plan ? 1 : 0
}

// Ensure all resources are explicitly defined to avoid implicit defaults causing drift.
module "storage" {
  source              = "./modules/st"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_name = var.storage_account_name
  count               = var.create_storage_account ? 1 : 0
}

module "function" {
  source                    = "./modules/func"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  storage_account_name      = module.storage[0].storage_account_name
  storage_account_access_key = module.storage[0].storage_account_access_key
  function_app_name         = var.function_app_name
  service_plan_id           = azurerm_service_plan.plan[0].id
  count                     = var.create_function_app ? 1 : 0
}

module "monitoring" {
  source              = "./modules/monitoring"
  location            = var.location
  resource_group_name = var.resource_group_name
  log_analytics_workspace_name = var.log_analytics_workspace_name
}

resource "azurerm_monitor_diagnostic_setting" "function_diagnostics" {
  name                       = "diag-function"
  target_resource_id         = module.function[0].function_app_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id

  enabled_log {
    category = "FunctionAppLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_storage_management_policy" "storage_policy" {
  storage_account_id = module.storage[0].storage_account_id

  rule {
    name    = "retention-policy"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
           }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_diagnostics" {
  name                       = "diag-storage"
  target_resource_id         = module.storage[0].storage_account_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id

  metric {
    category = "Transaction"
    enabled  = true
  }
}
