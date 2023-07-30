module "nat-vm" {
  source                        = "./modules/nat-vm"
  resource_group_name           = var.resource_group_name
  exisiting_resource_group_name = var.exisiting_resource_group_name
  location                      = var.location
  vnet                          = var.vnet
  tags                          = var.tags
  nat_gateway_name              = var.nat_gateway_name
  adgroup                       = var.adgroup
  admin_username                = var.admin_username
  computer_name                 = var.computer_name
}
