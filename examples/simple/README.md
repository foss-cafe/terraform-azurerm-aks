<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | ../.. | n/a |
| <a name="module_aks_log_analytics_workspace"></a> [aks\_log\_analytics\_workspace](#module\_aks\_log\_analytics\_workspace) | foss-cafe/log-analytics-workspace/azurerm | 1.0.2 |
| <a name="module_public_nsg"></a> [public\_nsg](#module\_public\_nsg) | foss-cafe/nsg/azurerm | 1.0.2 |
| <a name="module_public_subnets"></a> [public\_subnets](#module\_public\_subnets) | foss-cafe/subnets/azurerm | 1.0.3 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | foss-cafe/vnet/azurerm | 1.0.1 |
| <a name="module_workload_subnets"></a> [workload\_subnets](#module\_workload\_subnets) | foss-cafe/subnets/azurerm | 1.0.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | (Required) The address space that is used the virtual network. You can supply more than one address space. | `list(string)` | n/a | yes |
| <a name="input_custom_nsg_rules"></a> [custom\_nsg\_rules](#input\_custom\_nsg\_rules) | (Optional) Any Custom NSG rules you want to add | `any` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | `"East US"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name. | `string` | n/a | yes |
| <a name="input_public_subnet_address_prefixes"></a> [public\_subnet\_address\_prefixes](#input\_public\_subnet\_address\_prefixes) | (Required) The address prefixes to use for the subnet. | `list(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload_subnet_address_prefixes"></a> [workload\_subnet\_address\_prefixes](#input\_workload\_subnet\_address\_prefixes) | (Required) The address prefixes to use for the subnet. | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
