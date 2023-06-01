module "aks" {
  source              = "../.."
  create_aks          = true
  name                = format("%s-cluster", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = replace(format("%s-cluster", var.name), "/[\\W_]/", "-")
  default_node_pool = [{
    name                   = "default"
    node_count             = 1
    vm_size                = "Standard_DS2_v2"
    enable_host_encryption = false
    vnet_subnet_id         = module.workload_subnets.id
    os_disk_size_gb        = 30
    upgrade_settings = [
      {
        max_surge = 25
      }
    ]

    }
  ]
  ingress_application_gateway = [
    {
      gateway_name = format("%s-ingress", var.name)
      subnet_id    = module.public_subnets.id
    }
  ]
  key_vault_secrets_provider = [
    {
      secret_rotation_enabled = true
    }
  ]

  network_profile = [
    {
      network_plugin    = "azure"
      load_balancer_sku = "standard"
    }
  ]
  vnet_id = module.vnet.id

  identity = [{
    type = "SystemAssigned"
  }]

  auto_scaler_profile = [
    { max_unready_nodes = 1 }
  ]
  workload_autoscaler_profile = [
    { keda_enabled = false }
  ]

  oms_agent = [
    { log_analytics_workspace_id = module.aks_log_analytics_workspace.id }
  ]


  additional_node_pools = {
    "addon1" = {
      node_count             = 1
      vm_size                = "Standard_DS2_v2"
      enable_host_encryption = false
      vnet_subnet_id         = module.workload_subnets.id
      os_disk_size_gb        = 30
      upgrade_settings = [
        {
          max_surge = 25
        }
      ]

    }
  }

  tags = {
    Environment = "dev"
  }

}
