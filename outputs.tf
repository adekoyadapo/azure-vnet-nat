output "nat_ip" {
  value       = module.nat-vm.nat_gw_ip
  description = "Nat GW public IP"
}

output "vm_ip" {
  value       = module.nat-vm.vm_public_ip
  description = "VM public IP"
}

output "vm_name" {
  value = module.nat-vm.vm_name
  description = "VM Name"
}