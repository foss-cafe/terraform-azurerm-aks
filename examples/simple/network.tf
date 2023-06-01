# VNET
module "vnet" {
  source  = "foss-cafe/vnet/azurerm"
  version = "1.0.1"

  resource_group_name = var.resource_group_name
  location            = var.location

  name          = var.name
  address_space = var.address_space

  tags = var.tags
}


### Public Subnets
module "public_subnets" {
  source  = "foss-cafe/subnets/azurerm"
  version = "1.0.3"

  name                  = format("%s-public", var.name)
  resource_group_name   = var.resource_group_name
  virtual_network_name  = format("%s-vnet", var.name)
  address_prefixes      = var.public_subnet_address_prefixes
  associate_nat_gateway = false
  associate_nsg         = false

  depends_on = [module.vnet]
}

### 
module "workload_subnets" {
  source  = "foss-cafe/subnets/azurerm"
  version = "1.0.3"

  name                  = format("%s-workload", var.name)
  resource_group_name   = var.resource_group_name
  virtual_network_name  = format("%s-vnet", var.name)
  address_prefixes      = var.workload_subnet_address_prefixes
  service_endpoints     = ["Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.Storage"]
  associate_nat_gateway = true
  nat_gateway_id        = module.vnet.nat_id
  associate_nsg         = false

  depends_on = [module.vnet]
}

### NSG Rules for public subnets

module "public_nsg" {
  source  = "foss-cafe/nsg/azurerm"
  version = "1.0.2"

  name                = format("%s-public-nsg", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  associate_nsg       = true
  subnet_id           = module.public_subnets.id
  security_rule       = []
  custom_nsg_rules    = var.custom_nsg_rules
}

### Log Analystics 

module "aks_log_analytics_workspace" {
  source  = "foss-cafe/log-analytics-workspace/azurerm"
  version = "1.0.2"

  name                = format("%s-aks-law", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name
}
