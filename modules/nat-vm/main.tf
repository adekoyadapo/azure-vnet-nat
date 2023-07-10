data "azurerm_client_config" "current" {

}

resource "azurerm_resource_group" "rg" {
  count    = var.exisiting_resource_group_name == "" ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "random_string" "random" {
  count   = 3
  length  = 4
  lower   = true
  special = false
  upper   = false
  numeric = false
}

