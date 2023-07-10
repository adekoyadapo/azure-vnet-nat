<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nat-vm"></a> [nat-vm](#module\_nat-vm) | ./modules/nat-vm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adgroup"></a> [adgroup](#input\_adgroup) | Azure ad groups to filter through | `list(string)` | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | default vm username | `string` | n/a | yes |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | vm name | `string` | `"vm"` | no |
| <a name="input_location"></a> [location](#input\_location) | Resource Group Location | `string` | `"eastus"` | no |
| <a name="input_nat_gateway_name"></a> [nat\_gateway\_name](#input\_nat\_gateway\_name) | Nat gateway name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group Name | `string` | `"vnet-demo"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags | `map(any)` | <pre>{<br>  "Environment": "development"<br>}</pre> | no |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | Virtual networks | <pre>map(object({<br>    name          = string<br>    use_for_each  = optional(bool, true)<br>    is_source     = bool<br>    address_space = list(string)<br>    subnets = optional(list(object({<br>      name   = string<br>      prefix = string<br>    })))<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->