module "aks" {
  source                = "../.."
  agic_enabled          = true
  agic_name             = "sc-dev-ingress"
  app_gateway_subnet_id = "/subscriptions/xxxx/resourceGroups/sc-mobile-api-dev/providers/Microsoft.Network/virtualNetworks/xxxx/subnets/xxxx"
  ip_name               = "sc-dev-ingress"
  create_aks            = true
  name                  = "sc-dev"
  location              = "East US"
  resource_group_name   = "sc-mobile-api-dev"
  dns_prefix            = replace("sc-dev", "/[\\W_]/", "-")
  default_node_pool = [{
    name                   = "default"
    node_count             = 1
    vm_size                = "Standard_DS2_v2"
    enable_host_encryption = false
    vnet_subnet_id         = "/subscriptions/xxxx/resourceGroups/sc-mobile-api-dev/providers/Microsoft.Network/virtualNetworks/xxxx/subnets/aks-subnet"
    os_disk_size_gb        = 30
    upgrade_settings = [
      {
        max_surge = 25
      }
    ]

    }
  ]
  network_profile = [
    {
      network_plugin    = "azure"
      load_balancer_sku = "standard"
    }
  ]

  vnet_id = "/subscriptions/xxxx/resourceGroups/sc-mobile-api-dev/providers/Microsoft.Network/virtualNetworks/xxxx"

  identity = [{
    type = "SystemAssigned"
  }]

  tags = {
    Environment = "dev"
  }

}
