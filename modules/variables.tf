variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

# For function module
variable "storage_account_name" {
  type    = string
  default = ""
}

variable "storage_account_key" {
  type    = string
  default = ""
}
