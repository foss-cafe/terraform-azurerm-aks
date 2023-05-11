# Terraform module for Azure AKS

## How to use it as a module

```hcl
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aci_connector_linux"></a> [aci\_connector\_linux](#input\_aci\_connector\_linux) | (Optional) A aci\_connector\_linux block as defined below. For more details, please visit Create and configure an AKS cluster to use virtual nodes. | `any` | `[]` | no |
| <a name="input_agic_enabled"></a> [agic\_enabled](#input\_agic\_enabled) | description | `bool` | `true` | no |
| <a name="input_agic_name"></a> [agic\_name](#input\_agic\_name) | (Required) The name of the Application Gateway. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_agic_sku_capacity"></a> [agic\_sku\_capacity](#input\_agic\_sku\_capacity) | (Optional) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale\_configuration is set. | `number` | `2` | no |
| <a name="input_agic_sku_name"></a> [agic\_sku\_name](#input\_agic\_sku\_name) | (Optional) The Name of the SKU to use for this Application Gateway. Possible values are Standard\_Small, Standard\_Medium, Standard\_Large, Standard\_v2, WAF\_Medium, WAF\_Large, and WAF\_v2. | `string` | `"Standard_v2"` | no |
| <a name="input_agic_sku_tier"></a> [agic\_sku\_tier](#input\_agic\_sku\_tier) | (Optional) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard\_v2, WAF and WAF\_v2. | `string` | `"Standard_v2"` | no |
| <a name="input_api_server_access_profile"></a> [api\_server\_access\_profile](#input\_api\_server\_access\_profile) | (Optional) An api\_server\_access\_profile | `any` | `[]` | no |
| <a name="input_app_gateway_subnet_id"></a> [app\_gateway\_subnet\_id](#input\_app\_gateway\_subnet\_id) | (Required) ID of the subnet to use with the application gateway. | `string` | n/a | yes |
| <a name="input_appgw_backend_http_settings"></a> [appgw\_backend\_http\_settings](#input\_appgw\_backend\_http\_settings) | List of maps including backend http settings configurations. | `any` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| <a name="input_appgw_backend_pools"></a> [appgw\_backend\_pools](#input\_appgw\_backend\_pools) | List of maps including backend pool configurations. | `any` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| <a name="input_appgw_http_listeners"></a> [appgw\_http\_listeners](#input\_appgw\_http\_listeners) | List of maps including http listeners configurations. | `any` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| <a name="input_appgw_private_ip"></a> [appgw\_private\_ip](#input\_appgw\_private\_ip) | Private IP for Application Gateway. Used when variable `private_ingress` is set to `true`. | `string` | `null` | no |
| <a name="input_appgw_probes"></a> [appgw\_probes](#input\_appgw\_probes) | List of maps including request probes configurations. | `any` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| <a name="input_appgw_redirect_configuration"></a> [appgw\_redirect\_configuration](#input\_appgw\_redirect\_configuration) | List of maps including redirect configurations. | `list(map(string))` | `[]` | no |
| <a name="input_appgw_rewrite_rule_set"></a> [appgw\_rewrite\_rule\_set](#input\_appgw\_rewrite\_rule\_set) | Application gateway's rewrite rules | `any` | `[]` | no |
| <a name="input_appgw_routings"></a> [appgw\_routings](#input\_appgw\_routings) | List of maps including request routing rules configurations. | `list(map(string))` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| <a name="input_appgw_url_path_map"></a> [appgw\_url\_path\_map](#input\_appgw\_url\_path\_map) | List of maps including url path map configurations. | `any` | `[]` | no |
| <a name="input_authentication_certificate_configs"></a> [authentication\_certificate\_configs](#input\_authentication\_certificate\_configs) | List of maps including authentication certificate configurations. | `list(map(string))` | `[]` | no |
| <a name="input_auto_scaler_profile"></a> [auto\_scaler\_profile](#input\_auto\_scaler\_profile) | (Optional) A auto\_scaler\_profile block | `any` | `[]` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. | `string` | `null` | no |
| <a name="input_azure_active_directory_role_based_access_control"></a> [azure\_active\_directory\_role\_based\_access\_control](#input\_azure\_active\_directory\_role\_based\_access\_control) | (Optional) A azure\_active\_directory\_role\_based\_access\_control | `any` | `[]` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | (Optional) Should the Azure Policy Add-On be enabled? For more details please visit Understand Azure Policy for Azure Kubernetes Service | `bool` | `false` | no |
| <a name="input_confidential_computing"></a> [confidential\_computing](#input\_confidential\_computing) | (Optional) A confidential\_computing block | `any` | `[]` | no |
| <a name="input_create_aks"></a> [create\_aks](#input\_create\_aks) | Do you want to create AKS Cluster | `bool` | `true` | no |
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | (Required) A default\_node\_pool block | `any` | n/a | yes |
| <a name="input_disabled_rule_group_settings"></a> [disabled\_rule\_group\_settings](#input\_disabled\_rule\_group\_settings) | Appgw WAF rules group to disable. | `any` | `[]` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | (Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information can be found in the documentation. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | (Optional) DNS prefix specified when creating the managed cluster. Possible values must begin and end with a letter or number, contain only letters, numbers, and hyphens and be between 1 and 54 characters in length. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_dns_prefix_private_cluster"></a> [dns\_prefix\_private\_cluster](#input\_dns\_prefix\_private\_cluster) | (Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | (Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_enabled_waf"></a> [enabled\_waf](#input\_enabled\_waf) | Enable WAF or not. | `bool` | `false` | no |
| <a name="input_file_upload_limit_mb"></a> [file\_upload\_limit\_mb](#input\_file\_upload\_limit\_mb) | WAF configuration of the file upload limit in MB. | `number` | `100` | no |
| <a name="input_firewall_mode"></a> [firewall\_mode](#input\_firewall\_mode) | Appgw WAF mode. | `string` | `"Detection"` | no |
| <a name="input_frontend_port_settings"></a> [frontend\_port\_settings](#input\_frontend\_port\_settings) | description | `any` | <pre>[<br>  {<br>    "name": "default",<br>    "port": 90<br>  }<br>]</pre> | no |
| <a name="input_gateway_identity_id"></a> [gateway\_identity\_id](#input\_gateway\_identity\_id) | Id of the application gateway MSI. | `string` | `null` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | (Optional) Should HTTP Application Routing be enabled? | `bool` | `false` | no |
| <a name="input_http_proxy_config"></a> [http\_proxy\_config](#input\_http\_proxy\_config) | (Optional) A http\_proxy\_config block | `any` | `[]` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block as defined below. One of either identity or service\_principal must be specified. | `any` | `[]` | no |
| <a name="input_image_cleaner_enabled"></a> [image\_cleaner\_enabled](#input\_image\_cleaner\_enabled) | (Optional) Specifies whether Image Cleaner is enabled | `bool` | `false` | no |
| <a name="input_image_cleaner_interval_hours"></a> [image\_cleaner\_interval\_hours](#input\_image\_cleaner\_interval\_hours) | (Optional) Specifies the interval in hours when images should be cleaned up. Defaults to 48. | `number` | `48` | no |
| <a name="input_ingress_application_gateway"></a> [ingress\_application\_gateway](#input\_ingress\_application\_gateway) | (Optional) A ingress\_application\_gateway | `any` | `[]` | no |
| <a name="input_ip_allocation_method"></a> [ip\_allocation\_method](#input\_ip\_allocation\_method) | Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic. | `string` | `"Static"` | no |
| <a name="input_ip_name"></a> [ip\_name](#input\_ip\_name) | (Required) Specifies the name of the Public IP. Changing this forces a new Public IP to be created. | `string` | n/a | yes |
| <a name="input_ip_sku"></a> [ip\_sku](#input\_ip\_sku) | (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_key_management_service"></a> [key\_management\_service](#input\_key\_management\_service) | (Optional) A key\_management\_service block as defined below. For more details, please visit Key Management Service (KMS) etcd encryption to an AKS cluster. | `any` | `[]` | no |
| <a name="input_key_vault_secrets_provider"></a> [key\_vault\_secrets\_provider](#input\_key\_vault\_secrets\_provider) | (Optional) A key\_vault\_secrets\_provider block as defined below. For more details, please visit Azure Keyvault Secrets Provider for AKS. | `any` | `[]` | no |
| <a name="input_kubelet_identity"></a> [kubelet\_identity](#input\_kubelet\_identity) | (Optional) A kubelet\_identity block | `any` | `[]` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as 1.22 are also supported. - The minor version's latest GA patch is automatically chosen in that case. More details can be found in the documentation. | `string` | `null` | no |
| <a name="input_linux_profile"></a> [linux\_profile](#input\_linux\_profile) | (Optional) A linux\_profile block | `any` | `[]` | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | (Optional) If true local accounts will be disabled. See the documentation for more information. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Optional) A maintenance\_window block | `any` | `[]` | no |
| <a name="input_max_request_body_size_kb"></a> [max\_request\_body\_size\_kb](#input\_max\_request\_body\_size\_kb) | WAF configuration of the max request body size in KB. | `number` | `128` | no |
| <a name="input_microsoft_defender"></a> [microsoft\_defender](#input\_microsoft\_defender) | (Optional) A microsoft\_defender block | `any` | `[]` | no |
| <a name="input_monitor_metrics"></a> [monitor\_metrics](#input\_monitor\_metrics) | (Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster. A monitor\_metrics block as defined below. | `any` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_network_profile"></a> [network\_profile](#input\_network\_profile) | (Optional) A network\_profile block as defined below. Changing this forces a new resource to be created. | `any` | `[]` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | (Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | (Optional) Enable or Disable the OIDC issuer URL | `bool` | `false` | no |
| <a name="input_oms_agent"></a> [oms\_agent](#input\_oms\_agent) | (Optional) A oms\_agent block | `any` | `[]` | no |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | (Optional) Is Open Service Mesh enabled? For more details, please visit Open Service Mesh for AKS. | `bool` | `false` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of the SSLPolicy to use with Appgw. | `string` | `"AppGwSslPolicy20170401S"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | (Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_private_cluster_public_fqdn_enabled"></a> [private\_cluster\_public\_fqdn\_enabled](#input\_private\_cluster\_public\_fqdn\_enabled) | (Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false. | `bool` | `false` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | (Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise, the cluster will have issues after provisioning. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_private_ingress"></a> [private\_ingress](#input\_private\_ingress) | Private ingress boolean variable. When `true`, the default http listener will listen on private IP instead of the public IP. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_request_body_check"></a> [request\_body\_check](#input\_request\_body\_check) | WAF should check the request body. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | (Optional) Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_rule_set_type"></a> [rule\_set\_type](#input\_rule\_set\_type) | WAF rules set type. | `string` | `"OWASP"` | no |
| <a name="input_rule_set_version"></a> [rule\_set\_version](#input\_rule\_set\_version) | WAF rules set version. | `string` | `"3.0"` | no |
| <a name="input_run_command_enabled"></a> [run\_command\_enabled](#input\_run\_command\_enabled) | (Optional) Whether to enable run command for the cluster or not. Defaults to true. | `bool` | `true` | no |
| <a name="input_service_mesh_profile"></a> [service\_mesh\_profile](#input\_service\_mesh\_profile) | (Optional) A service\_mesh\_profile block | `any` | `[]` | no |
| <a name="input_service_principal"></a> [service\_principal](#input\_service\_principal) | (Optional) A service\_principal block as documented below. One of either identity or service\_principal must be specified. | `any` | `[]` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free, and Standard (which includes the Uptime SLA). Defaults to Free. | `string` | `"Standard"` | no |
| <a name="input_ssl_certificates_configs"></a> [ssl\_certificates\_configs](#input\_ssl\_certificates\_configs) | List of maps including ssl certificates configurations. | `list(map(string))` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_trusted_root_certificate_configs"></a> [trusted\_root\_certificate\_configs](#input\_trusted\_root\_certificate\_configs) | Trusted root certificate configurations. | `list(map(string))` | `[]` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | (Required) Vnet id that Aks MSI should be network contributor in a private cluster | `string` | n/a | yes |
| <a name="input_waf_exclusion_settings"></a> [waf\_exclusion\_settings](#input\_waf\_exclusion\_settings) | Appgw WAF exclusion settings. | `any` | `[]` | no |
| <a name="input_workload_autoscaler_profile"></a> [workload\_autoscaler\_profile](#input\_workload\_autoscaler\_profile) | (Optional) A workload\_autoscaler\_profile | `any` | `[]` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | (Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false. | `bool` | `false` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created. | `list(any)` | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
