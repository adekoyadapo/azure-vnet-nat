module "vnet" {
  source   = "Azure/vnet/azurerm"
  version  = "4.1.0"
  for_each = var.vnet

  vnet_name           = format("vnet-%s-%s", each.value.name, random_string.random[0].result)
  vnet_location       = var.location
  resource_group_name = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name
  address_space       = each.value.address_space
  subnet_prefixes     = [for i in var.vnet[each.key].subnets : i.prefix]
  subnet_names        = [for i in var.vnet[each.key].subnets : i.name]
  use_for_each        = each.value.use_for_each
  tags                = var.tags

  nsg_ids = each.key == element(keys(local.source_vnet), 0) ? { element(local.source_subnets_list, 0) = azurerm_network_security_group.vm.id } : {}
}

resource "azurerm_virtual_network_peering" "source" {
  name                      = format("peering-to-%s", one([for i in var.vnet : i.name if i.is_source == false]))
  resource_group_name       = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name
  virtual_network_name      = module.vnet[one([for i in var.vnet : i.name if i.is_source == true])].vnet_name
  remote_virtual_network_id = module.vnet[one([for i in var.vnet : i.name if i.is_source == false])].vnet_id
  allow_forwarded_traffic   = true

}

resource "azurerm_virtual_network_peering" "destination" {
  name                      = format("peering-to-%s", one([for i in var.vnet : i.name if i.is_source == true]))
  resource_group_name       = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name
  virtual_network_name      = module.vnet[one([for i in var.vnet : i.name if i.is_source == false])].vnet_name
  remote_virtual_network_id = module.vnet[one([for i in var.vnet : i.name if i.is_source == true])].vnet_id
  # use_remote_gateways       = true
  allow_forwarded_traffic = true

}
