locals {
  source_vnet         = { for i, j in var.vnet : i => { for k in j.subnets : k.name => k.prefix } if j.is_source == true }
  source_subnets_list = flatten([for i, j in local.source_vnet : [for k, l in j : k]])
  source_subnets      = toset(flatten([for i, j in local.source_vnet : [for k, l in j : k]]))
  source_subnets_id   = { for i in local.source_subnets : i => module.vnet[one([for a in var.vnet : a.name if a.is_source == true])].vnet_subnets_name_id[i] }
  vm_subnet_id        = element([for i, j in local.source_subnets_id : j], 0)
  vm_subnet_name      = element([for i, j in local.source_subnets_id : i], 0)
}
