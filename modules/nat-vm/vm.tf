# VM
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "azuread_group" "adgroup" {
  for_each     = var.adgroup == [] ? [] : toset(var.adgroup)
  display_name = each.key
}

# Create virtual machine network
resource "azurerm_public_ip" "pubip_vm" {
  name                = format("pubip-%s-%s", var.computer_name, random_string.random[2].result)
  location            = var.location
  resource_group_name = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name
  allocation_method   = "Static"
  tags                = var.tags
  sku                 = var.nat_gw_pubip_sku
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = format("%s-%s", var.computer_name, random_string.random[2].result)
  location              = var.location
  resource_group_name   = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name
  network_interface_ids = [azurerm_network_interface.nic_vm.id]
  size                  = var.vm_size

  os_disk {
    name                 = format("vmOsDisk-%s-%s", var.computer_name, random_string.random[2].result)
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  identity {
    type = "SystemAssigned"
  }
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  computer_name                   = format("vm-%s-%s", var.computer_name, random_string.random[2].result)
  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = "${trimspace(tls_private_key.ssh.public_key_openssh)} ${var.admin_username}"
  }
  depends_on = [azurerm_nat_gateway.nat_gw]
  tags       = var.tags
}

resource "azurerm_network_interface" "nic_vm" {
  name                = format("vm_NIC-%s-%s", var.computer_name, random_string.random[2].result)
  location            = var.location
  resource_group_name = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name

  ip_configuration {
    name                          = format("NicConfiguration-%s-%s", var.computer_name, random_string.random[2].result)
    subnet_id                     = local.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubip_vm.id
  }
  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "ad-login" {
  count                      = var.adgroup == [] ? 0 : 1
  name                       = format("ad-login-%s", random_string.random[2].result)
  publisher                  = "Microsoft.Azure.ActiveDirectory.LinuxSSH"
  type                       = "AADLoginForLinux"
  type_handler_version       = "1.0"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm.id
  auto_upgrade_minor_version = true
}

resource "azurerm_role_assignment" "assign-vm-role" {
  for_each             = var.adgroup == [] ? [] : toset(var.adgroup)
  scope                = azurerm_linux_virtual_machine.vm.id
  role_definition_name = "Virtual Machine Administrator Login"
  principal_id         = data.azuread_group.adgroup[each.key].object_id
  depends_on = [
    azurerm_virtual_machine_extension.ad-login, azurerm_virtual_machine_extension.ad-login
  ]
}

# Network security
resource "azurerm_network_security_group" "vm" {
  name                = format("nsg-%s", random_string.random[2].result)
  location            = var.location
  resource_group_name = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_ranges    = security_rule.value["destination_port_ranges"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
  tags = merge(
  { "resource" = "firewall" }, var.tags)
}

data "azurerm_public_ip" "vm_ip" {
  name                = azurerm_public_ip.pubip_vm.name
  resource_group_name = var.exisiting_resource_group_name == "" ? var.resource_group_name : var.exisiting_resource_group_name
  depends_on          = [azurerm_linux_virtual_machine.vm]
}
