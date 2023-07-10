<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~>2.28.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.64.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.3.2 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~>4.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~>2.28.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.64.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~>3.3.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~>4.0.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vnet"></a> [vnet](#module\_vnet) | Azure/vnet/azurerm | 4.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.nat_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_interface.nic_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.nat_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.pubip_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.assign-vm-role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet_nat_gateway_association.nat_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_virtual_machine_extension.ad-login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_network_peering.destination](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.source](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azuread_group.adgroup](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_public_ip.vm_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adgroup"></a> [adgroup](#input\_adgroup) | Azure ad groups to filter through | `list(string)` | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | default vm username | `string` | `"natgw"` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | vm name | `string` | `"vm"` | no |
| <a name="input_exisiting_resource_group_name"></a> [exisiting\_resource\_group\_name](#input\_exisiting\_resource\_group\_name) | Existing resource Group | `string` | `""` | no |
| <a name="input_image_offer"></a> [image\_offer](#input\_image\_offer) | azure image offer | `string` | `"UbuntuServer"` | no |
| <a name="input_image_publisher"></a> [image\_publisher](#input\_image\_publisher) | azure image publisher | `string` | `"Canonical"` | no |
| <a name="input_image_sku"></a> [image\_sku](#input\_image\_sku) | azure image version sku | `string` | `"18.04-LTS"` | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Vm image version | `string` | `"latest"` | no |
| <a name="input_location"></a> [location](#input\_location) | Resource Group Location | `string` | `"eastus"` | no |
| <a name="input_nat_gateway_name"></a> [nat\_gateway\_name](#input\_nat\_gateway\_name) | Nat gateway name | `string` | `"ngw"` | no |
| <a name="input_nat_gateway_sku"></a> [nat\_gateway\_sku](#input\_nat\_gateway\_sku) | Nat Gateway sku | `string` | `"Standard"` | no |
| <a name="input_nat_gw_pubip_sku"></a> [nat\_gw\_pubip\_sku](#input\_nat\_gw\_pubip\_sku) | Public IP sku | `string` | `"Standard"` | no |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | Set of required network firewall rules | <pre>list(object({<br>    name                       = string<br>    priority                   = number<br>    direction                  = optional(string, "Inbound")<br>    access                     = optional(string, "Allow")<br>    protocol                   = optional(string, "Tcp")<br>    source_port_range          = optional(string, "*")<br>    destination_port_ranges    = list(string)<br>    source_address_prefix      = optional(string, "*")<br>    destination_address_prefix = optional(string, "*")<br>  }))</pre> | <pre>[<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_ranges": [<br>      "22"<br>    ],<br>    "direction": "Inbound",<br>    "name": "ssh",<br>    "priority": 1000,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "*"<br>  }<br>]</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group Name | `string` | `"vnet-demo"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags | `map(any)` | <pre>{<br>  "Environment": "development"<br>}</pre> | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | VM size | `string` | `"Standard_B1s"` | no |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | Virtual networks | <pre>map(object({<br>    name          = string<br>    use_for_each  = optional(bool, true)<br>    is_source     = bool<br>    address_space = list(string)<br>    subnets = optional(list(object({<br>      name   = string<br>      prefix = string<br>    })))<br>  }))</pre> | <pre>{<br>  "demo-a": {<br>    "address_space": [<br>      "10.0.0.0/16"<br>    ],<br>    "is_source": true,<br>    "name": "demo-a",<br>    "subnets": [<br>      {<br>        "name": "subnet-a",<br>        "prefix": "10.0.0.0/24"<br>      },<br>      {<br>        "name": "subnet-b",<br>        "prefix": "10.0.1.0/24"<br>      }<br>    ]<br>  },<br>  "demo-b": {<br>    "address_space": [<br>      "10.1.0.0/16"<br>    ],<br>    "is_source": false,<br>    "name": "demo-b",<br>    "subnets": [<br>      {<br>        "name": "subnet-a",<br>        "prefix": "10.1.0.0/24"<br>      },<br>      {<br>        "name": "subnet-b",<br>        "prefix": "10.1.1.0/24"<br>      }<br>    ]<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_ssh_key"></a> [admin\_ssh\_key](#output\_admin\_ssh\_key) | Admin ssh keys |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Name of VM admin |
| <a name="output_nat_gw_ip"></a> [nat\_gw\_ip](#output\_nat\_gw\_ip) | nat gateway IP |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | name of VM |
| <a name="output_vm_public_ip"></a> [vm\_public\_ip](#output\_vm\_public\_ip) | Vm public IP |
<!-- END_TF_DOCS -->