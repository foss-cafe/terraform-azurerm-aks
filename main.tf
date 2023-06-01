resource "azurerm_user_assigned_identity" "this" {
  count = var.create_aks ? 1 : 0

  name                = format("%s-aks-identity", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_role_assignment" "this" {
  count = var.create_aks ? 1 : 0

  scope                = var.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.this[0].principal_id
}

resource "azurerm_kubernetes_cluster" "this" {
  count = var.create_aks ? 1 : 0

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "default_node_pool" {
    for_each = var.default_node_pool

    content {
      name                          = try(default_node_pool.value.name)
      vm_size                       = try(default_node_pool.value.vm_size)
      capacity_reservation_group_id = try(default_node_pool.value.capacity_reservation_group_id, null)
      custom_ca_trust_enabled       = try(default_node_pool.value.custom_ca_trust_enabled, null)
      enable_auto_scaling           = try(default_node_pool.value.enable_auto_scaling, false)
      enable_host_encryption        = try(default_node_pool.value.enable_host_encryption, true)
      enable_node_public_ip         = try(default_node_pool.value.enable_node_public_ip, false)
      host_group_id                 = try(default_node_pool.value.host_group_id, null)

      dynamic "kubelet_config" {
        for_each = try(default_node_pool.value.kubelet_config, [])

        content {
          allowed_unsafe_sysctls    = try(kubelet_config.value.allowed_unsafe_sysctls, null)
          container_log_max_line    = try(kubelet_config.value.container_log_max_line, null)
          container_log_max_size_mb = try(kubelet_config.value.container_log_max_size_mb, null)
          cpu_cfs_quota_enabled     = try(kubelet_config.value.cpu_cfs_quota_enabled, null)
          cpu_cfs_quota_period      = try(kubelet_config.value.cpu_cfs_quota_period, null)
          cpu_manager_policy        = try(kubelet_config.value.cpu_manager_policy, null)
          image_gc_high_threshold   = try(kubelet_config.value.image_gc_high_threshold, null)
          image_gc_low_threshold    = try(kubelet_config.value.image_gc_low_threshold, null)
          pod_max_pid               = try(kubelet_config.value.pod_max_pid, null)
          topology_manager_policy   = try(kubelet_config.value.topology_manager_policy, null)
        }

      }

      dynamic "linux_os_config" {
        for_each = try(default_node_pool.value.linux_os_config, [])

        content {
          swap_file_size_mb             = try(linux_os_config.value.swap_file_size_mb, null)
          transparent_huge_page_defrag  = try(linux_os_config.value.transparent_huge_page_defrag, null)
          transparent_huge_page_enabled = try(linux_os_config.value.transparent_huge_page_enabled, null)

          dynamic "sysctl_config" {
            for_each = try(linux_os_config.value.sysctl_config, [])
            content {
              fs_aio_max_nr                      = try(sysctl_config.value.fs_aio_max_nr, null)
              fs_file_max                        = try(sysctl_config.value.fs_file_max, null)
              fs_inotify_max_user_watches        = try(sysctl_config.value.fs_inotify_max_user_watches, null)
              fs_nr_open                         = try(sysctl_config.value.fs_nr_open, null)
              kernel_threads_max                 = try(sysctl_config.value.kernel_threads_max, null)
              net_core_netdev_max_backlog        = try(sysctl_config.value.net_core_netdev_max_backlog, null)
              net_core_optmem_max                = try(sysctl_config.value.net_core_optmem_max, null)
              net_core_rmem_default              = try(sysctl_config.value.net_core_rmem_default, null)
              net_core_rmem_max                  = try(sysctl_config.value.net_core_rmem_max, null)
              net_core_somaxconn                 = try(sysctl_config.value.net_core_somaxconn, null)
              net_core_wmem_default              = try(sysctl_config.value.net_core_wmem_default, null)
              net_core_wmem_max                  = try(sysctl_config.value.net_core_wmem_max, null)
              net_ipv4_ip_local_port_range_max   = try(sysctl_config.value.net_ipv4_ip_local_port_range_max, null)
              net_ipv4_ip_local_port_range_min   = try(sysctl_config.value.net_ipv4_ip_local_port_range_min, null)
              net_ipv4_neigh_default_gc_thresh1  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh1, null)
              net_ipv4_neigh_default_gc_thresh2  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh2, null)
              net_ipv4_neigh_default_gc_thresh3  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh3, null)
              net_ipv4_tcp_fin_timeout           = try(sysctl_config.value.net_ipv4_tcp_fin_timeout, null)
              net_ipv4_tcp_keepalive_intvl       = try(sysctl_config.value.net_ipv4_tcp_keepalive_intvl, null)
              net_ipv4_tcp_keepalive_probes      = try(sysctl_config.value.net_ipv4_tcp_keepalive_probes, null)
              net_ipv4_tcp_keepalive_time        = try(sysctl_config.value.net_ipv4_tcp_keepalive_time, null)
              net_ipv4_tcp_max_syn_backlog       = try(sysctl_config.value.net_ipv4_tcp_max_syn_backlog, null)
              net_ipv4_tcp_max_tw_buckets        = try(sysctl_config.value.net_ipv4_tcp_max_tw_buckets, null)
              net_ipv4_tcp_tw_reuse              = try(sysctl_config.value.net_ipv4_tcp_tw_reuse, null)
              net_netfilter_nf_conntrack_buckets = try(sysctl_config.value.net_netfilter_nf_conntrack_buckets, null)
              net_netfilter_nf_conntrack_max     = try(sysctl_config.value.net_netfilter_nf_conntrack_max, null)
              vm_max_map_count                   = try(sysctl_config.value.vm_max_map_count, null)
              vm_swappiness                      = try(sysctl_config.value.vm_swappiness, null)
              vm_vfs_cache_pressure              = try(sysctl_config.value.vm_vfs_cache_pressure, null)
            }
          }
        }
      }
      fips_enabled       = try(default_node_pool.value.fips_enabled, null)
      kubelet_disk_type  = try(default_node_pool.value.kubelet_disk_type, "OS")
      max_pods           = try(default_node_pool.value.max_pods, 50)
      message_of_the_day = try(default_node_pool.value.message_of_the_day, null)
      dynamic "node_network_profile" {
        for_each = try(default_node_pool.value.node_network_profile, [])

        content {
          node_public_ip_tags = try(node_network_profile.value.node_public_ip_tags, {})
        }
      }
      node_public_ip_prefix_id     = try(default_node_pool.value.node_public_ip_prefix_id, null)
      node_labels                  = try(default_node_pool.value.node_labels, {})
      node_taints                  = try(default_node_pool.value.node_taints, [])
      only_critical_addons_enabled = try(default_node_pool.value.only_critical_addons_enabled, null)
      orchestrator_version         = try(default_node_pool.value.orchestrator_version, null)
      os_disk_size_gb              = try(default_node_pool.value.os_disk_size_gb, 100)
      os_disk_type                 = try(default_node_pool.value.os_disk_type, "Managed")
      os_sku                       = try(default_node_pool.value.os_sku, "Ubuntu")
      pod_subnet_id                = try(default_node_pool.value.pod_subnet_id, null)
      proximity_placement_group_id = try(default_node_pool.value.proximity_placement_group_id, null)
      scale_down_mode              = try(default_node_pool.value.scale_down_mode, "Delete")
      temporary_name_for_rotation  = try(default_node_pool.value.temporary_name_for_rotation, null)
      type                         = try(default_node_pool.value.type, "VirtualMachineScaleSets")
      tags                         = var.tags
      ultra_ssd_enabled            = try(default_node_pool.value.ultra_ssd_enabled, false)

      dynamic "upgrade_settings" {
        for_each = try(default_node_pool.value.upgrade_settings, [])
        content {
          max_surge = try(upgrade_settings.value.max_surge)
        }
      }
      vnet_subnet_id   = try(default_node_pool.value.vnet_subnet_id, null)
      workload_runtime = try(default_node_pool.value.workload_runtime, "OCIContainer")
      zones            = try(default_node_pool.value.zones, [])
      max_count        = try(default_node_pool.value.max_count, null)
      min_count        = try(default_node_pool.value.min_count, null)
      node_count       = try(default_node_pool.value.enable_auto_scaling, true) ? try(default_node_pool.value.min_count, 1) : 1

    }
  }

  dns_prefix                 = var.dns_prefix
  dns_prefix_private_cluster = var.dns_prefix_private_cluster

  dynamic "aci_connector_linux" {
    for_each = var.aci_connector_linux

    content {
      subnet_name = try(aci_connector_linux.value.subnet_name)
    }

  }


  automatic_channel_upgrade = var.automatic_channel_upgrade

  dynamic "api_server_access_profile" {
    for_each = var.api_server_access_profile

    content {
      authorized_ip_ranges     = try(api_server_access_profile.value.authorized_ip_ranges, "0.0.0.0/32")
      subnet_id                = try(api_server_access_profile.value.subnet_id, null)
      vnet_integration_enabled = try(api_server_access_profile.value.vnet_integration_enabled, false)
    }

  }

  dynamic "auto_scaler_profile" {
    for_each = var.auto_scaler_profile

    content {
      balance_similar_node_groups      = try(auto_scaler_profile.value.balance_similar_node_groups, false)
      expander                         = try(auto_scaler_profile.value.expander, "random")
      max_graceful_termination_sec     = try(auto_scaler_profile.value.max_graceful_termination_sec, 600)
      max_node_provisioning_time       = try(auto_scaler_profile.value.max_node_provisioning_time, "15m")
      max_unready_nodes                = try(auto_scaler_profile.value.max_unready_nodes, 1)
      max_unready_percentage           = try(auto_scaler_profile.value.max_unready_percentage, 45)
      new_pod_scale_up_delay           = try(auto_scaler_profile.value.new_pod_scale_up_delay, "10s")
      scale_down_delay_after_add       = try(auto_scaler_profile.value.scale_down_delay_after_add, "10m")
      scale_down_delay_after_delete    = try(auto_scaler_profile.value.scale_down_delay_after_delete, "10s")
      scale_down_delay_after_failure   = try(auto_scaler_profile.value.scale_down_delay_after_failure, "3m")
      scan_interval                    = try(auto_scaler_profile.value.scan_interval, "10s")
      scale_down_unneeded              = try(auto_scaler_profile.value.scale_down_unneeded, "10m")
      scale_down_unready               = try(auto_scaler_profile.value.scale_down_unready, "20m")
      scale_down_utilization_threshold = try(auto_scaler_profile.value.scale_down_utilization_threshold, "0.5")
      empty_bulk_delete_max            = try(auto_scaler_profile.value.empty_bulk_delete_max, "10")
      skip_nodes_with_local_storage    = try(auto_scaler_profile.value.skip_nodes_with_local_storage, true)
      skip_nodes_with_system_pods      = try(auto_scaler_profile.value.skip_nodes_with_system_pods, true)

    }

  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_active_directory_role_based_access_control

    content {
      managed   = try(azure_active_directory_role_based_access_control.value.managed, null)
      tenant_id = try(azure_active_directory_role_based_access_control.value.tenant_id, null)
    }

  }

  azure_policy_enabled = var.azure_policy_enabled

  dynamic "confidential_computing" {
    for_each = var.confidential_computing

    content {
      sgx_quote_helper_enabled = try(confidential_computing.value.sgx_quote_helper_enabled)
    }
  }

  disk_encryption_set_id           = var.disk_encryption_set_id
  edge_zone                        = var.edge_zone
  http_application_routing_enabled = var.http_application_routing_enabled

  dynamic "http_proxy_config" {
    for_each = var.http_proxy_config
    content {
      http_proxy  = try(http_proxy_config.value.http_proxy, null)
      https_proxy = try(http_proxy_config.value.https_proxy, null)
      no_proxy    = try(http_proxy_config.value.no_proxy, null)
    }
  }

  dynamic "identity" {
    for_each = var.identity

    content {
      type         = try(identity.value.type)
      identity_ids = try(identity.value.identity_ids, [])
    }
  }

  image_cleaner_enabled        = var.image_cleaner_enabled
  image_cleaner_interval_hours = var.image_cleaner_interval_hours

  dynamic "ingress_application_gateway" {
    for_each = var.ingress_application_gateway

    content {
      gateway_id   = try(ingress_application_gateway.value.gateway_id, null)
      gateway_name = try(ingress_application_gateway.value.gateway_name, null)
      subnet_cidr  = try(ingress_application_gateway.value.subnet_cidr, null)
      subnet_id    = try(ingress_application_gateway.value.subnet_id, null)
    }
  }

  dynamic "key_management_service" {
    for_each = var.key_management_service
    content {
      key_vault_key_id         = try(key_management_service.value.key_vault_key_id)
      key_vault_network_access = try(key_management_service.value.key_vault_network_access, "Public")
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider
    content {
      secret_rotation_enabled  = try(key_vault_secrets_provider.value.key_vault_key_id, null)
      secret_rotation_interval = try(key_vault_secrets_provider.value.secret_rotation_interval, "2m")
    }
  }

  dynamic "kubelet_identity" {
    for_each = var.kubelet_identity
    content {
      client_id                 = try(kubelet_identity.value.client_id, null)
      object_id                 = try(kubelet_identity.value.object_id, null)
      user_assigned_identity_id = try(kubelet_identity.value.user_assigned_identity_id, null)
    }

  }

  kubernetes_version = var.kubernetes_version

  dynamic "linux_profile" {
    for_each = var.linux_profile
    content {
      admin_username = try(linux_profile.value.admin_username)
      dynamic "ssh_key" {
        for_each = try(linux_profile.value.ssh_key)
        content {
          key_data = try(ssh_key.value.key_data)
        }

      }
    }
  }

  local_account_disabled = var.local_account_disabled

  dynamic "maintenance_window" {
    for_each = var.maintenance_window

    content {
      dynamic "allowed" {
        for_each = try(maintenance_window.value.allowed, [])
        content {
          day   = try(allowed.value.day)
          hours = try(allowed.value.hours)
        }
      }
      dynamic "not_allowed" {
        for_each = try(maintenance_window.value.not_allowed, [])
        content {
          end   = try(not_allowed.value.end)
          start = try(not_allowed.value.start)
        }
      }
    }
  }
  dynamic "microsoft_defender" {
    for_each = var.microsoft_defender
    content {
      log_analytics_workspace_id = try(microsoft_defender.value.log_analytics_workspace_id)
    }
  }

  dynamic "monitor_metrics" {
    for_each = var.monitor_metrics
    content {
      annotations_allowed = try(monitor_metrics.value.annotations_allowed, null)
      labels_allowed      = try(monitor_metrics.value.labels_allowed, null)
    }
  }

  dynamic "network_profile" {
    for_each = var.network_profile
    content {
      network_plugin      = try(network_profile.value.network_plugin, "azure")
      network_mode        = try(network_profile.value.network_mode, "transparent")
      network_policy      = try(network_profile.value.network_policy, "azure")
      dns_service_ip      = try(network_profile.value.dns_service_ip, null)
      docker_bridge_cidr  = try(network_profile.value.docker_bridge_cidr, null)
      ebpf_data_plane     = try(network_profile.value.ebpf_data_plane, null)
      network_plugin_mode = try(network_profile.value.network_plugin_mode, null)
      outbound_type       = try(network_profile.value.outbound_type, null)
      pod_cidr            = try(network_profile.value.pod_cidr, null)
      pod_cidrs           = try(network_profile.value.pod_cidrs, [])
      service_cidr        = try(network_profile.value.service_cidr, null)
      service_cidrs       = try(network_profile.value.service_cidrs, [])
      ip_versions         = try(network_profile.value.ip_versions, null)
      load_balancer_sku   = try(network_profile.value.load_balancer_sku, "standard")

      dynamic "load_balancer_profile" {
        for_each = try(network_profile.value.load_balancer_profile, [])

        content {
          idle_timeout_in_minutes     = try(load_balancer_profile.value.idle_timeout_in_minutes, 30)
          managed_outbound_ip_count   = try(load_balancer_profile.value.managed_outbound_ip_count, null)
          managed_outbound_ipv6_count = try(load_balancer_profile.value.managed_outbound_ipv6_count, 0)
          outbound_ip_address_ids     = try(load_balancer_profile.value.outbound_ip_address_ids, null)
          outbound_ip_prefix_ids      = try(load_balancer_profile.value.outbound_ip_prefix_ids, 0)
          outbound_ports_allocated    = try(load_balancer_profile.value.outbound_ports_allocated, 0)

        }

      }

      dynamic "nat_gateway_profile" {
        for_each = try(network_profile.value.nat_gateway_profile, [])

        content {
          idle_timeout_in_minutes   = try(nat_gateway_profile.value.idle_timeout_in_minutes, 4)
          managed_outbound_ip_count = try(nat_gateway_profile.value.managed_outbound_ip_count, null)
        }

      }
    }
  }

  node_resource_group = var.node_resource_group
  oidc_issuer_enabled = var.oidc_issuer_enabled

  dynamic "oms_agent" {
    for_each = var.oms_agent
    content {
      log_analytics_workspace_id      = try(oms_agent.value.log_analytics_workspace_id)
      msi_auth_for_monitoring_enabled = try(oms_agent.value.msi_auth_for_monitoring_enabled, false)
    }
  }

  open_service_mesh_enabled           = var.open_service_mesh_enabled
  private_cluster_enabled             = var.private_cluster_enabled
  private_dns_zone_id                 = var.private_dns_zone_id
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled

  dynamic "service_mesh_profile" {
    for_each = var.service_mesh_profile

    content {
      mode = try(service_mesh_profile.value.mode, "Istio")
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = var.workload_autoscaler_profile

    content {
      keda_enabled                    = try(workload_autoscaler_profile.value.keda_enabled, null)
      vertical_pod_autoscaler_enabled = try(workload_autoscaler_profile.value.vertical_pod_autoscaler_enabled, null)
    }
  }

  workload_identity_enabled         = var.workload_identity_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  role_based_access_control_enabled = var.role_based_access_control_enabled
  run_command_enabled               = var.run_command_enabled

  dynamic "service_principal" {
    for_each = var.service_principal

    content {
      client_id     = try(service_principal.value.client_id)
      client_secret = try(service_principal.value.client_secret)
    }
  }

  sku_tier = var.sku_tier

  tags = var.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      network_profile,
      kubelet_identity,
    ]
  }

}

# Allow user assigned identity to manage AKS items in RG
resource "azurerm_role_assignment" "rg_level" {
  principal_id         = azurerm_kubernetes_cluster.this[0].kubelet_identity[0].object_id
  scope                = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.this.subscription_id, var.resource_group_name)
  role_definition_name = "Contributor"
}

resource "azurerm_role_assignment" "vnet_level" {
  count = var.create_aks ? 1 : 0

  scope                = var.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.this[0].kubelet_identity[0].object_id
}


resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each = var.additional_node_pools

  name                          = each.key
  kubernetes_cluster_id         = azurerm_kubernetes_cluster.this[0].id
  vm_size                       = try(each.value.vm_size)
  capacity_reservation_group_id = try(each.value.capacity_reservation_group_id, null)
  custom_ca_trust_enabled       = try(each.value.custom_ca_trust_enabled, false)
  enable_auto_scaling           = try(each.value.enable_auto_scaling, true)
  enable_host_encryption        = try(each.value.enable_host_encryption, false)
  enable_node_public_ip         = try(each.value.enable_node_public_ip, false)
  eviction_policy               = try(each.value.eviction_policy, null)
  host_group_id                 = try(each.value.host_group_id, null)

  dynamic "kubelet_config" {
    for_each = try(each.value.kubelet_config, [])

    content {
      allowed_unsafe_sysctls    = try(kubelet_config.value.allowed_unsafe_sysctls, null)
      container_log_max_line    = try(kubelet_config.value.container_log_max_line, null)
      container_log_max_size_mb = try(kubelet_config.value.container_log_max_size_mb, null)
      cpu_cfs_quota_enabled     = try(kubelet_config.value.cpu_cfs_quota_enabled, null)
      cpu_cfs_quota_period      = try(kubelet_config.value.cpu_cfs_quota_period, null)
      cpu_manager_policy        = try(kubelet_config.value.cpu_manager_policy, null)
      image_gc_high_threshold   = try(kubelet_config.value.image_gc_high_threshold, null)
      image_gc_low_threshold    = try(kubelet_config.value.image_gc_low_threshold, null)
      pod_max_pid               = try(kubelet_config.value.pod_max_pid, null)
      topology_manager_policy   = try(kubelet_config.value.topology_manager_policy, null)
    }

  }

  dynamic "linux_os_config" {
    for_each = try(each.value.linux_os_config, [])

    content {
      swap_file_size_mb             = try(linux_os_config.value.swap_file_size_mb, null)
      transparent_huge_page_defrag  = try(linux_os_config.value.transparent_huge_page_defrag, null)
      transparent_huge_page_enabled = try(linux_os_config.value.transparent_huge_page_enabled, null)

      dynamic "sysctl_config" {
        for_each = try(linux_os_config.value.sysctl_config, [])
        content {
          fs_aio_max_nr                      = try(sysctl_config.value.fs_aio_max_nr, null)
          fs_file_max                        = try(sysctl_config.value.fs_file_max, null)
          fs_inotify_max_user_watches        = try(sysctl_config.value.fs_inotify_max_user_watches, null)
          fs_nr_open                         = try(sysctl_config.value.fs_nr_open, null)
          kernel_threads_max                 = try(sysctl_config.value.kernel_threads_max, null)
          net_core_netdev_max_backlog        = try(sysctl_config.value.net_core_netdev_max_backlog, null)
          net_core_optmem_max                = try(sysctl_config.value.net_core_optmem_max, null)
          net_core_rmem_default              = try(sysctl_config.value.net_core_rmem_default, null)
          net_core_rmem_max                  = try(sysctl_config.value.net_core_rmem_max, null)
          net_core_somaxconn                 = try(sysctl_config.value.net_core_somaxconn, null)
          net_core_wmem_default              = try(sysctl_config.value.net_core_wmem_default, null)
          net_core_wmem_max                  = try(sysctl_config.value.net_core_wmem_max, null)
          net_ipv4_ip_local_port_range_max   = try(sysctl_config.value.net_ipv4_ip_local_port_range_max, null)
          net_ipv4_ip_local_port_range_min   = try(sysctl_config.value.net_ipv4_ip_local_port_range_min, null)
          net_ipv4_neigh_default_gc_thresh1  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh1, null)
          net_ipv4_neigh_default_gc_thresh2  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh2, null)
          net_ipv4_neigh_default_gc_thresh3  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh3, null)
          net_ipv4_tcp_fin_timeout           = try(sysctl_config.value.net_ipv4_tcp_fin_timeout, null)
          net_ipv4_tcp_keepalive_intvl       = try(sysctl_config.value.net_ipv4_tcp_keepalive_intvl, null)
          net_ipv4_tcp_keepalive_probes      = try(sysctl_config.value.net_ipv4_tcp_keepalive_probes, null)
          net_ipv4_tcp_keepalive_time        = try(sysctl_config.value.net_ipv4_tcp_keepalive_time, null)
          net_ipv4_tcp_max_syn_backlog       = try(sysctl_config.value.net_ipv4_tcp_max_syn_backlog, null)
          net_ipv4_tcp_max_tw_buckets        = try(sysctl_config.value.net_ipv4_tcp_max_tw_buckets, null)
          net_ipv4_tcp_tw_reuse              = try(sysctl_config.value.net_ipv4_tcp_tw_reuse, null)
          net_netfilter_nf_conntrack_buckets = try(sysctl_config.value.net_netfilter_nf_conntrack_buckets, null)
          net_netfilter_nf_conntrack_max     = try(sysctl_config.value.net_netfilter_nf_conntrack_max, null)
          vm_max_map_count                   = try(sysctl_config.value.vm_max_map_count, null)
          vm_swappiness                      = try(sysctl_config.value.vm_swappiness, null)
          vm_vfs_cache_pressure              = try(sysctl_config.value.vm_vfs_cache_pressure, null)
        }
      }
    }
  }
  fips_enabled       = try(each.value.host_group_id, null)
  kubelet_disk_type  = try(each.value.kubelet_disk_type, "OS")
  max_pods           = try(each.value.max_pods, 50)
  message_of_the_day = try(each.value.message_of_the_day, null)
  mode               = try(each.value.mode, "System")

  dynamic "node_network_profile" {
    for_each = try(each.value.node_network_profile, [])

    content {
      node_public_ip_tags = try(node_network_profile.value.node_public_ip_tags, {})
    }

  }

  node_labels                  = try(each.value.node_labels, {})
  node_public_ip_prefix_id     = try(each.value.node_public_ip_prefix_id, null)
  node_taints                  = try(each.value.node_taints, [])
  orchestrator_version         = try(each.value.orchestrator_version, null)
  os_disk_size_gb              = try(each.value.os_disk_size_gb, 30)
  os_disk_type                 = try(each.value.os_disk_type, "Ephemeral")
  pod_subnet_id                = try(each.value.pod_subnet_id, null)
  os_sku                       = try(each.value.os_sku, "Ubuntu")
  os_type                      = try(each.value.os_type, "Linux")
  priority                     = try(each.value.priority, "Regular")
  proximity_placement_group_id = try(each.value.proximity_placement_group_id, null)
  spot_max_price               = try(each.value.spot_max_price, null)
  /* snapshot_id                  = try(each.value.snapshot_id, null) */
  scale_down_mode   = try(each.value.scale_down_mode, "Delete")
  ultra_ssd_enabled = try(each.value.ultra_ssd_enabled, false)

  dynamic "upgrade_settings" {
    for_each = try(each.value.upgrade_settings, [])
    content {
      max_surge = try(upgrade_settings.value.max_surge)
    }
  }

  vnet_subnet_id = try(each.value.vnet_subnet_id)

  dynamic "windows_profile" {
    for_each = try(each.value.windows_profile, [])

    content {
      outbound_nat_enabled = try(upgrade_settings.value.outbound_nat_enabled, false)
    }
  }

  workload_runtime = try(each.value.workload_runtime, "OCIContainer")
  zones            = try(each.value.zones, [])
  max_count        = try(each.value.enable_auto_scaling, true) ? try(each.value.max_count, 4) : null
  min_count        = try(each.value.enable_auto_scaling, true) ? try(each.value.min_count, 1) : null
  node_count       = try(each.value.enable_auto_scaling, true) ? try(each.value.min_count, 1) : 1
  tags             = try(each.value.tags, {})
}
