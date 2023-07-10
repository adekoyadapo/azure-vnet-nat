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
  default = {
    "demo-a" = {
      name          = "demo-a"
      address_space = ["10.0.0.0/16"]
      is_source     = true
      subnets = [
        {
          name   = "subnet-a"
          prefix = "10.0.0.0/24"
        },
        {
          name   = "subnet-b"
          prefix = "10.0.1.0/24"
        }
      ]
    },
    "demo-b" = {
      name          = "demo-b"
      address_space = ["10.1.0.0/16"]
      is_source     = false
      subnets = [
        {
          name   = "subnet-a"
          prefix = "10.1.0.0/24"
        },
        {
          name   = "subnet-b"
          prefix = "10.1.1.0/24"
        }
      ]
    }
  }
}

variable "nat_gateway_name" {
  description = "Nat gateway name"
  type        = string
  default     = "ngw"
}

variable "nat_gw_pubip_sku" {
  description = "Public IP sku"
  type        = string
  default     = "Standard"
}

variable "nat_gateway_sku" {
  description = "Nat Gateway sku"
  type        = string
  default     = "Standard"
}
variable "adgroup" {
  description = "Azure ad groups to filter through"
  type        = list(string)
  default     = []
}

variable "vm_size" {
  type        = string
  description = "VM size"
  default     = "Standard_B1s"
}

variable "image_version" {
  description = "Vm image version"
  type        = string
  default     = "latest"
}

variable "image_publisher" {
  type        = string
  description = "azure image publisher"
  default     = "Canonical"
}
variable "image_offer" {
  type        = string
  description = "azure image offer"
  default     = "UbuntuServer"
}
variable "image_sku" {
  type        = string
  description = "azure image version sku"
  default     = "18.04-LTS"
}
variable "computer_name" {
  type        = string
  description = "vm name"
  default     = "vm"
}
variable "admin_username" {
  type        = string
  description = "default vm username"
  default     = "natgw"
}
variable "nsg_rules" {
  description = "Set of required network firewall rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = optional(string, "Inbound")
    access                     = optional(string, "Allow")
    protocol                   = optional(string, "Tcp")
    source_port_range          = optional(string, "*")
    destination_port_ranges    = list(string)
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
  }))
  default = [{
    name                       = "ssh",
    priority                   = 1000,
    direction                  = "Inbound",
    access                     = "Allow",
    protocol                   = "Tcp",
    source_port_range          = "*",
    destination_port_ranges    = ["22"],
    source_address_prefix      = "*",
    destination_address_prefix = "*",
  }]

}
