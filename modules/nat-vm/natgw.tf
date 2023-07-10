resource "azurerm_public_ip" "nat_gw" {
  name                = format("nat-gw-pubip-%s", var.nat_gateway_name)
  location            = var.location
  resource_group_name = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name
  allocation_method   = "Static"
  sku                 = var.nat_gw_pubip_sku
}
resource "azurerm_nat_gateway" "nat_gw" {
  name                    = format("nat-gateway-%s", var.nat_gateway_name)
  location                = var.location
  resource_group_name     = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name
  sku_name                = var.nat_gateway_sku
  idle_timeout_in_minutes = 10
}
resource "azurerm_nat_gateway_public_ip_association" "nat_gw" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gw.id
}
resource "azurerm_subnet_nat_gateway_association" "nat_gw" {
  for_each       = local.source_subnets_id
  subnet_id      = each.value
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}
