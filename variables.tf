### Ingress
variable "agic_enabled" {
  type        = bool
  description = "description"
  default     = true
}

variable "ip_name" {
  type        = string
  description = "(Required) Specifies the name of the Public IP. Changing this forces a new Public IP to be created."
}

variable "ip_allocation_method" {
  type        = string
  description = "Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  default     = "Static"
}

variable "ip_sku" {
  type        = string
  description = " (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. Changing this forces a new resource to be created."
  default     = "Standard"
}

variable "zones" {
  type        = list(any)
  description = "(Optional) A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created."
  default     = []
}


variable "agic_name" {
  type        = string
  description = "(Required) The name of the Application Gateway. Changing this forces a new resource to be created."
}

variable "agic_sku_capacity" {
  type        = number
  description = "(Optional) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set."
  default     = 2
}

variable "agic_sku_name" {
  type        = string
  description = "(Optional) The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2."
  default     = "Standard_v2"
}

variable "agic_sku_tier" {
  type        = string
  description = "(Optional) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2."
  default     = "Standard_v2"
}

variable "private_ingress" {
  type        = bool
  description = "Private ingress boolean variable. When `true`, the default http listener will listen on private IP instead of the public IP."
  default     = false
}

variable "appgw_private_ip" {
  description = "Private IP for Application Gateway. Used when variable `private_ingress` is set to `true`."
  type        = string
  default     = null
}

variable "frontend_port_settings" {
  type        = any
  description = "description"
  default = [
    {
      "name" = "default"
      "port" = 90
    }
  ]
}

variable "app_gateway_subnet_id" {
  description = "(Required) ID of the subnet to use with the application gateway."
  type        = string
}

variable "gateway_identity_id" {
  type        = string
  description = "Id of the application gateway MSI."
  default     = null
}

variable "appgw_http_listeners" {
  type        = any
  description = "List of maps including http listeners configurations."
  default     = [{ fake = "fake" }]
}

variable "appgw_backend_pools" {
  type        = any
  description = "List of maps including backend pool configurations."
  default     = [{ fake = "fake" }]
}

variable "ssl_certificates_configs" {
  type        = list(map(string))
  description = "List of maps including ssl certificates configurations."
  default     = []
}

variable "authentication_certificate_configs" {
  type        = list(map(string))
  description = "List of maps including authentication certificate configurations."
  default     = []
}

variable "trusted_root_certificate_configs" {
  type        = list(map(string))
  description = "Trusted root certificate configurations."
  default     = []
}

variable "appgw_routings" {
  type        = list(map(string))
  description = "List of maps including request routing rules configurations."
  default     = [{ fake = "fake" }]
}

variable "appgw_rewrite_rule_set" {
  type        = any
  description = "Application gateway's rewrite rules"
  default     = []
}

variable "appgw_probes" {
  type        = any
  description = "List of maps including request probes configurations."
  default = [
    {
      fake = "fake"
  }]
}

variable "appgw_url_path_map" {
  type        = any
  description = "List of maps including url path map configurations."
  default     = []
}

variable "appgw_redirect_configuration" {
  type        = list(map(string))
  description = "List of maps including redirect configurations."
  default     = []
}


### WAF

variable "enabled_waf" {
  type        = bool
  description = "Enable WAF or not."
  default     = false
}

variable "firewall_mode" {
  type        = string
  description = "Appgw WAF mode."
  default     = "Detection"
}

variable "file_upload_limit_mb" {
  type        = number
  description = "WAF configuration of the file upload limit in MB."
  default     = 100
}

variable "max_request_body_size_kb" {
  default     = 128
  description = "WAF configuration of the max request body size in KB."
  type        = number
}

variable "request_body_check" {
  type        = bool
  description = "WAF should check the request body."
  default     = true
}

variable "rule_set_type" {
  type        = string
  description = "WAF rules set type."
  default     = "OWASP"
}

variable "rule_set_version" {
  type        = string
  description = "WAF rules set version."
  default     = "3.0"
}

variable "disabled_rule_group_settings" {
  type        = any
  description = "Appgw WAF rules group to disable."
  default     = []
}

variable "waf_exclusion_settings" {
  type        = any
  description = "Appgw WAF exclusion settings."
  default     = []
}

variable "policy_name" {
  type        = string
  description = "Name of the SSLPolicy to use with Appgw."
  default     = "AppGwSslPolicy20170401S"
}

variable "appgw_backend_http_settings" {
  type        = any
  description = "List of maps including backend http settings configurations."
  default     = [{ fake = "fake" }]
}



### AKS
variable "create_aks" {
  type        = bool
  description = "Do you want to create AKS Cluster"
  default     = true
}

variable "name" {
  type        = string
  description = "(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
}

variable "dns_prefix" {
  type        = string
  description = "(Optional) DNS prefix specified when creating the managed cluster. Possible values must begin and end with a letter or number, contain only letters, numbers, and hyphens and be between 1 and 54 characters in length. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_prefix_private_cluster" {
  type        = string
  description = "(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created."
  default     = null
}

variable "automatic_channel_upgrade" {
  type        = string
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none."
  default     = null
}

variable "azure_policy_enabled" {
  type        = bool
  description = "(Optional) Should the Azure Policy Add-On be enabled? For more details please visit Understand Azure Policy for Azure Kubernetes Service"
  default     = false
}


variable "disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information can be found in the documentation. Changing this forces a new resource to be created."
  default     = null
}

variable "edge_zone" {
  type        = string
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "http_application_routing_enabled" {
  type        = bool
  description = "(Optional) Should HTTP Application Routing be enabled?"
  default     = false
}

variable "image_cleaner_enabled" {
  type        = bool
  description = "(Optional) Specifies whether Image Cleaner is enabled"
  default     = false
}

variable "image_cleaner_interval_hours" {
  type        = number
  description = " (Optional) Specifies the interval in hours when images should be cleaned up. Defaults to 48."
  default     = 48
}

variable "kubernetes_version" {
  type        = string
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as 1.22 are also supported. - The minor version's latest GA patch is automatically chosen in that case. More details can be found in the documentation."
  default     = null
}

variable "local_account_disabled" {
  type        = bool
  description = "(Optional) If true local accounts will be disabled. See the documentation for more information."
  default     = false
}

variable "node_resource_group" {
  type        = string
  description = "(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "oidc_issuer_enabled" {
  type        = bool
  description = "(Optional) Enable or Disable the OIDC issuer URL"
  default     = false
}

variable "open_service_mesh_enabled" {
  type        = bool
  description = "(Optional) Is Open Service Mesh enabled? For more details, please visit Open Service Mesh for AKS."
  default     = false
}

variable "private_cluster_enabled" {
  type        = bool
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  default     = false
}

variable "private_dns_zone_id" {
  type        = string
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise, the cluster will have issues after provisioning. Changing this forces a new resource to be created."
  default     = null
}

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false."
  default     = false
}

variable "workload_identity_enabled" {
  type        = bool
  description = "(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created."
  default     = true
}

variable "role_based_access_control_enabled" {
  type        = bool
  description = "(Optional) Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created."
  default     = true
}

variable "run_command_enabled" {
  type        = bool
  description = "(Optional) Whether to enable run command for the cluster or not. Defaults to true."
  default     = true
}

variable "sku_tier" {
  type        = string
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free, and Standard (which includes the Uptime SLA). Defaults to Free."
  default     = "Standard"
}

variable "default_node_pool" {
  type        = any
  description = "(Required) A default_node_pool block"
}

variable "api_server_access_profile" {
  type        = any
  description = "(Optional) An api_server_access_profile"
  default     = []
}

variable "auto_scaler_profile" {
  type        = any
  description = "(Optional) A auto_scaler_profile block"
  default     = []
}

variable "azure_active_directory_role_based_access_control" {
  type        = any
  description = "(Optional) A azure_active_directory_role_based_access_control"
  default     = []
}

variable "confidential_computing" {
  type        = any
  description = "(Optional) A confidential_computing block"
  default     = []
}

variable "http_proxy_config" {
  type        = any
  description = "(Optional) A http_proxy_config block"
  default     = []
}

variable "identity" {
  type        = any
  description = "(Optional) An identity block as defined below. One of either identity or service_principal must be specified."
  default     = []
}

variable "ingress_application_gateway" {
  type        = any
  description = "(Optional) A ingress_application_gateway"
  default     = []
}

variable "key_management_service" {
  type        = any
  description = "(Optional) A key_management_service block as defined below. For more details, please visit Key Management Service (KMS) etcd encryption to an AKS cluster."
  default     = []
}

variable "key_vault_secrets_provider" {
  type        = any
  description = "(Optional) A key_vault_secrets_provider block as defined below. For more details, please visit Azure Keyvault Secrets Provider for AKS."
  default     = []
}

variable "kubelet_identity" {
  type        = any
  description = "(Optional) A kubelet_identity block"
  default     = []
}

variable "linux_profile" {
  type        = any
  description = "(Optional) A linux_profile block"
  default     = []
}

variable "maintenance_window" {
  type        = any
  description = "(Optional) A maintenance_window block"
  default     = []
}

variable "microsoft_defender" {
  type        = any
  description = "(Optional) A microsoft_defender block"
  default     = []
}

variable "monitor_metrics" {
  type        = any
  description = "(Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster. A monitor_metrics block as defined below."
  default     = []
}

variable "network_profile" {
  type        = any
  description = " (Optional) A network_profile block as defined below. Changing this forces a new resource to be created."
  default     = []
}

variable "oms_agent" {
  type        = any
  description = "(Optional) A oms_agent block"
  default     = []
}

variable "service_mesh_profile" {
  type        = any
  description = "(Optional) A service_mesh_profile block"
  default     = []
}

variable "workload_autoscaler_profile" {
  type        = any
  description = "(Optional) A workload_autoscaler_profile"
  default     = []
}

variable "service_principal" {
  type        = any
  description = "(Optional) A service_principal block as documented below. One of either identity or service_principal must be specified."
  default     = []
}

variable "aci_connector_linux" {
  type        = any
  description = "(Optional) A aci_connector_linux block as defined below. For more details, please visit Create and configure an AKS cluster to use virtual nodes."
  default     = []
}


variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable "vnet_id" {
  type        = string
  description = "(Required) Vnet id that Aks MSI should be network contributor in a private cluster"

}
