variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = "East US"
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name."
}

variable "address_space" {
  type        = list(string)
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
}


### Subnets
variable "public_subnet_address_prefixes" {
  type        = list(string)
  description = "(Required) The address prefixes to use for the subnet."
}
variable "workload_subnet_address_prefixes" {
  type        = list(string)
  description = "(Required) The address prefixes to use for the subnet."
}

variable "custom_nsg_rules" {
  type        = any
  description = "(Optional) Any Custom NSG rules you want to add"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
