// Remove duplicate output definitions as they are already defined in main.tf

output "function_app_id" {
  value = azurerm_linux_function_app.function.id
}
