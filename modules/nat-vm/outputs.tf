output "vm_name" {
  description = "name of VM"
  value       = azurerm_linux_virtual_machine.vm.computer_name
}

output "admin_username" {
  description = "Name of VM admin"
  value       = azurerm_linux_virtual_machine.vm.admin_username
}

output "admin_ssh_key" {
  description = "Admin ssh keys"
  value       = azurerm_linux_virtual_machine.vm.admin_ssh_key
}

output "vm_public_ip" {
  description = "Vm public IP"
  value       = data.azurerm_public_ip.vm_ip.ip_address
}

output "nat_gw_ip" {
  description = "nat gateway IP"
  value       = azurerm_public_ip.nat_gw.ip_address
}

