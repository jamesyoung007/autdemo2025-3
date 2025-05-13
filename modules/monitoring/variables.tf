variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "log_analytics_workspace_name" {
  type = string
}

variable "sku" {
  type = string
  default = "PerGB2018"
}

variable "retention_in_days" {
  type = number
  default = 30
}
