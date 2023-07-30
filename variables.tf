variable "tags" {
  description = "tags"
  type        = map(any)
  default = {
    "Environment" = "development"
  }
}
variable "location" {
  description = "Resource Group Location"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "vnet-demo"
}

variable "exisiting_resource_group_name" {
  description = "Existing resource Group"
  type        = string
  default     = ""
}

variable "vnet" {
  description = "Virtual networks"
  type = map(object({
    name          = string
    use_for_each  = optional(bool, true)
    is_source     = bool
    address_space = list(string)
    subnets = optional(list(object({
      name   = string
      prefix = string
    })))
  }))
}
variable "adgroup" {
  description = "Azure ad groups to filter through"
  type        = list(string)
  default     = []
}
variable "computer_name" {
  type        = string
  description = "vm name"
  default     = "vm"
}
variable "admin_username" {
  type        = string
  description = "default vm username"
}

variable "nat_gateway_name" {
  description = "Nat gateway name"
  type        = string
}
