variable "location" {
  type    = string
  default = "Australia East"
}

variable "resource_group_name" {
  type    = string
  default = "AUT-2025-demo_2"
}

variable "create_service_plan" {
  type    = bool
  default = true
}

variable "create_storage_account" {
  type    = bool
  default = true
}

variable "create_function_app" {
  type    = bool
  default = true
}

variable "log_analytics_workspace_name" {
  type    = string
  default = "autdemo2-law"
}

variable "storage_account_name" {
  type    = string
  default = "autdemo2storage12"
}

variable "function_app_name" {
  type    = string
  default = "autdemo-functionapp1234"
}
