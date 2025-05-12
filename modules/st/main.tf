module "storage_account" {
  source = "./modules/storage_account"

  resource_group_name = var.resource_group_name
  location            = var.location
}

output "storage_account_name" {
  value = module.storage_account.name
}

output "storage_account_access_key" {
  value = module.storage_account.primary_access_key
}

output "storage_account_id" {
  value = module.storage_account.id
}
