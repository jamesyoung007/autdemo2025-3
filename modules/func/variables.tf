variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_access_key" {
  type = string
}

variable "function_app_name" {
  type = string
}

variable "service_plan_id" {
  type = string
}

variable "service_plan_name" {
  type = string
}

variable "service_plan_sku" {
  type = string
}

variable "node_version" {
  type = string
  default = "18"
}
