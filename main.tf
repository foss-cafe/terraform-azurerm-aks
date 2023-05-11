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
              fs_file_max                        = try(sysctl_config.value.fs_aio_max_nr, null)
              fs_inotify_max_user_watches        = try(sysctl_config.value.fs_aio_max_nr, null)
              fs_nr_open                         = try(sysctl_config.value.fs_aio_max_nr, null)
              kernel_threads_max                 = try(sysctl_config.value.fs_aio_max_nr, null)
              net_core_netdev_max_backlog        = try(sysctl_config.value.fs_aio_max_nr, null)
              net_core_optmem_max                = try(sysctl_config.value.fs_aio_max_nr, null)
              net_core_rmem_default              = try(sysctl_config.value.fs_aio_max_nr, null)
              net_core_rmem_max                  = try(sysctl_config.value.fs_aio_max_nr, null)
              net_core_somaxconn                 = try(sysctl_config.value.fs_aio_max_nr, null)
              net_core_wmem_default              = try(sysctl_config.value.fs_aio_max_nr, null)
              net_core_wmem_max                  = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_ip_local_port_range_max   = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_ip_local_port_range_min   = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_neigh_default_gc_thresh1  = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_neigh_default_gc_thresh2  = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_neigh_default_gc_thresh3  = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_tcp_fin_timeout           = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_tcp_keepalive_intvl       = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_tcp_keepalive_probes      = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_tcp_keepalive_time        = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_tcp_max_syn_backlog       = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_tcp_max_tw_buckets        = try(sysctl_config.value.fs_aio_max_nr, null)
              net_ipv4_tcp_tw_reuse              = try(sysctl_config.value.fs_aio_max_nr, null)
              net_netfilter_nf_conntrack_buckets = try(sysctl_config.value.fs_aio_max_nr, null)
              net_netfilter_nf_conntrack_max     = try(sysctl_config.value.fs_aio_max_nr, null)
              vm_max_map_count                   = try(sysctl_config.value.fs_aio_max_nr, null)
              vm_swappiness                      = try(sysctl_config.value.fs_aio_max_nr, null)
              vm_vfs_cache_pressure              = try(sysctl_config.value.fs_aio_max_nr, null)
            }
          }
        }
      }
      fips_enabled       = try(default_node_pool.value.fips_enabled, null)
      kubelet_disk_type  = try(default_node_pool.value.kubelet_disk_type, "OS")
      max_pods           = try(default_node_pool.value.max_pods, 110)
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
      os_disk_size_gb              = try(default_node_pool.value.orchestrator_version, 100)
      os_disk_type                 = try(default_node_pool.value.orchestrator_version, "Managed")
      os_sku                       = try(default_node_pool.value.orchestrator_version, "Ubuntu")
      pod_subnet_id                = try(default_node_pool.value.orchestrator_version, null)
      proximity_placement_group_id = try(default_node_pool.value.orchestrator_version, null)
      scale_down_mode              = try(default_node_pool.value.orchestrator_version, "Delete")
      temporary_name_for_rotation  = try(default_node_pool.value.orchestrator_version, null)
      type                         = try(default_node_pool.value.orchestrator_version, "VirtualMachineScaleSets")
      tags                         = try(default_node_pool.value.tags, {})
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
      node_count       = try(default_node_pool.value.node_count, 3)

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
      max_unready_nodes                = try(auto_scaler_profile.value.max_unready_nodes, 3)
      max_unready_percentage           = try(auto_scaler_profile.value.max_unready_percentage, 45)
      new_pod_scale_up_delay           = try(auto_scaler_profile.value.new_pod_scale_up_delay, "10s")
      scale_down_delay_after_add       = try(auto_scaler_profile.value.scale_down_delay_after_add, "10m")
      scale_down_delay_after_delete    = try(auto_scaler_profile.value.scale_down_delay_after_delete, "10s")
      scale_down_delay_after_failure   = try(auto_scaler_profile.value.scale_down_delay_after_failure, "3m")
      scan_interval                    = try(auto_scaler_profile.value.scan_interval, "10s")
      scale_down_unneeded              = try(auto_scaler_profile.value.scale_down_unneeded, false)
      scale_down_unready               = try(auto_scaler_profile.value.scale_down_unready, false)
      scale_down_utilization_threshold = try(auto_scaler_profile.value.scale_down_utilization_threshold, false)
      empty_bulk_delete_max            = try(auto_scaler_profile.value.empty_bulk_delete_max, false)
      skip_nodes_with_local_storage    = try(auto_scaler_profile.value.skip_nodes_with_local_storage, false)
      skip_nodes_with_system_pods      = try(auto_scaler_profile.value.skip_nodes_with_system_pods, false)

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
      effective_gateway_id = try(ingress_application_gateway.value.effective_gateway_id)

      dynamic "ingress_application_gateway_identity" {
        for_each = try(ingress_application_gateway.value.ingress_application_gateway_identity, [])
        content {
          client_id                 = try(ingress_application_gateway_identity.value.client_id)
          object_id                 = try(ingress_application_gateway_identity.value.object_id)
          user_assigned_identity_id = try(ingress_application_gateway_identity.value.user_assigned_identity_id)
        }
      }


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
      network_plugin_mode = try(network_profile.value.network_plugin_mode, "Overlay")
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
      msi_auth_for_monitoring_enabled = try(oms_agent.value.msi_auth_for_monitoring_enabled)
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

}

/* # Allow user assigned identity to manage AKS items in RG
resource "azurerm_role_assignment" "this" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  scope                = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.this.subscription_id, var.resource_group_name)
  role_definition_name = "Contributor"
}

resource "azurerm_role_assignment" "this" {
  count = var.create_aks ? 1 : 0

  scope                = var.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}  */
