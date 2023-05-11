resource "azurerm_public_ip" "this" {
  count               = var.agic_enabled ? 1 : 0
  location            = var.location
  name                = var.ip_name
  allocation_method   = var.ip_allocation_method
  resource_group_name = var.resource_group_name
  sku                 = var.ip_sku

  domain_name_label = format("%s-pip", var.ip_name)
  zones             = var.zones

  tags = var.tags
}

resource "azurerm_application_gateway" "this" {
  count               = var.agic_enabled ? 1 : 0
  location            = var.location
  name                = var.agic_name
  resource_group_name = var.resource_group_name

  #
  # Common
  #

  sku {
    capacity = var.agic_sku_capacity
    name     = var.agic_sku_name
    tier     = var.agic_sku_tier
  }

  zones = var.zones

  frontend_ip_configuration {
    name                 = format("%s-frontipconfig", var.agic_name)
    public_ip_address_id = azurerm_public_ip.this[0].id
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.private_ingress ? ["fake"] : []
    content {
      name                          = var.frontend_priv_ip_configuration_name
      private_ip_address_allocation = var.private_ingress ? "Static" : null
      private_ip_address            = var.private_ingress ? var.appgw_private_ip : null
      subnet_id                     = var.private_ingress ? var.app_gateway_subnet_id : null
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port_settings
    content {
      name = try(frontend_port.value.name, "default")
      port = try(frontend_port.value.port, "80")
    }
  }

  dynamic "identity" {
    for_each = var.gateway_identity_id != null ? ["fake"] : []
    content {
      type         = "UserAssigned"
      identity_ids = [var.gateway_identity_id]
    }
  }

  gateway_ip_configuration {
    name      = format("%s-ipconfig", var.agic_name)
    subnet_id = var.app_gateway_subnet_id
  }

  ###  Azure seems to don't take care of enabled = false and throw an error
  ###    about wrong SKU to use with WAF. So we dynamically disable it

  dynamic "waf_configuration" {
    for_each = var.enabled_waf ? ["fake"] : []
    content {
      enabled                  = var.enabled_waf
      file_upload_limit_mb     = var.file_upload_limit_mb
      firewall_mode            = var.firewall_mode
      max_request_body_size_kb = var.max_request_body_size_kb
      request_body_check       = var.request_body_check
      rule_set_type            = var.rule_set_type
      rule_set_version         = var.rule_set_version

      dynamic "disabled_rule_group" {
        for_each = var.disabled_rule_group_settings
        content {
          rule_group_name = try(disabled_rule_group.value.rule_group_name)
          rules           = try(disabled_rule_group_settings.value.rules)
        }
      }

      dynamic "exclusion" {
        for_each = var.waf_exclusion_settings
        content {
          match_variable          = try(exclusion.value.match_variable)
          selector                = try(exclusion.value.selector)
          selector_match_operator = try(exclusion.value.selector_match_operator)
        }
      }
    }
  }


  ssl_policy {
    policy_type = "Predefined"
    policy_name = var.policy_name
  }

  #
  # Backend HTTP settings
  #

  dynamic "backend_http_settings" {
    for_each = var.appgw_backend_http_settings
    content {
      name       = try(backend_http_settings.value.name, "dummy")
      path       = try(backend_http_settings.value.path, "/")
      probe_name = try(backend_http_settings.value.probe_name, "dummy")

      affinity_cookie_name                = "ApplicationGatewayAffinity"
      cookie_based_affinity               = try(backend_http_settings.value.cookie_based_affinity, "Disabled")
      pick_host_name_from_backend_address = try(backend_http_settings.value.pick_host_name_from_backend_address, false)
      host_name                           = try(backend_http_settings.value.host_name, "dummy")
      port                                = try(backend_http_settings.value.port, 80)
      protocol                            = try(backend_http_settings.value.protocol, "Http")
      request_timeout                     = try(backend_http_settings.value.request_timeout, 1)
      trusted_root_certificate_names      = try(backend_http_settings.value.trusted_root_certificate_names, [])
    }
  }

  #
  # HTTP listener
  #

  dynamic "http_listener" {
    for_each = var.appgw_http_listeners
    content {
      name                           = try(http_listener.value.name, "dummy")
      frontend_ip_configuration_name = try(http_listener.value.frontend_ip_configuration_name, format("%s-frontipconfig", var.agic_name))
      frontend_port_name             = try(http_listener.value.frontend_port_name, "dummy")
      protocol                       = try(http_listener.value.protocol, "Http")
      ssl_certificate_name           = try(http_listener.value.ssl_certificate_name, null)
      host_name                      = try(http_listener.value.host_name, "dummy")
      require_sni                    = try(http_listener.value.require_sni, null)
    }
  }

  #
  # Backend address pool
  #

  dynamic "backend_address_pool" {
    for_each = var.appgw_backend_pools
    content {
      name  = try(backend_address_pool.value.name, "dummy")
      fqdns = try(backend_address_pool.value.fqdns, ["dummy"])
    }
  }

  #
  # SSL certificate
  #

  dynamic "ssl_certificate" {
    for_each = toset(var.ssl_certificates_configs)
    content {
      name                = try(ssl_certificate.value.name)
      data                = try(ssl_certificate.value.key_vault_secret_id) == "" ? base64((try(ssl_certificate.value.data))) : null
      password            = try(ssl_certificate.value.key_vault_secret_id) == "" ? try(ssl_certificate.value.password) : null
      key_vault_secret_id = try(ssl_certificate.value.data) == "" ? try(ssl_certificate.value.key_vault_secret_id) : null
    }
  }

  #
  # Authentication certificate
  #

  dynamic "authentication_certificate" {
    for_each = var.authentication_certificate_configs
    content {
      name = lookup(authentication_certificate.value, "name")
      data = filebase64(lookup(authentication_certificate.value, "data"))
    }
  }

  #
  # Trusted root certificate
  #

  dynamic "trusted_root_certificate" {
    for_each = var.trusted_root_certificate_configs
    content {
      name = lookup(trusted_root_certificate.value, "name")
      data = filebase64(lookup(trusted_root_certificate.value, "data"))
    }
  }

  #
  # Request routing rule
  #

  dynamic "request_routing_rule" {
    for_each = var.appgw_routings
    content {
      name      = try(request_routing_rule.value.name, "dummy")
      rule_type = try(request_routing_rule.value.rule_type, "Basic")

      http_listener_name          = try(request_routing_rule.value.http_listener_name, try(request_routing_rule.value.name, "dummy"))
      backend_address_pool_name   = try(request_routing_rule.value.backend_address_pool_name, try(request_routing_rule.value.name, "dummy"))
      backend_http_settings_name  = try(request_routing_rule.value.backend_http_settings_name, try(request_routing_rule.value.name, "dummy"))
      url_path_map_name           = try(request_routing_rule.value.url_path_map_name, null)
      redirect_configuration_name = try(request_routing_rule.value.redirect_configuration_name, null)
      rewrite_rule_set_name       = try(request_routing_rule.value.rewrite_rule_set_name, null)
      priority                    = try(request_routing_rule.value.priority, 1)
    }
  }

  #
  # Rewrite rule set
  #

  dynamic "rewrite_rule_set" {
    for_each = var.appgw_rewrite_rule_set
    content {
      name = lookup(rewrite_rule_set.value.name, null)
      dynamic "rewrite_rule" {
        for_each = try(rewrite_rule_set.value.rewrite_rule)
        content {
          name          = try(rewrite_rule.value.name)
          rule_sequence = try(rewrite_rule.value.rule_sequence)

          condition {
            ignore_case = try(rewrite_rule.value.condition_ignore_case, null)
            negate      = try(rewrite_rule.value.condition_negate, null)
            pattern     = try(rewrite_rule.value.condition_pattern, null)
            variable    = try(rewrite_rule.value.condition_variable, null)
          }

          response_header_configuration {
            header_name  = try(rewrite_rule.value.response_header_name, null)
            header_value = try(rewrite_rule.value.response_header_value, null)
          }
        }
      }
    }
  }

  #
  # Probe
  #

  dynamic "probe" {
    for_each = var.appgw_probes
    content {
      host                = try(probe.value.host, "dummy")
      interval            = try(probe.value.interval, 30)
      name                = try(probe.value.name, "dummy")
      path                = try(probe.value.path, "/")
      protocol            = try(probe.value.protocol, "Http")
      timeout             = try(probe.value.timeout, 30)
      unhealthy_threshold = try(probe.value.unhealthy_threshold, 3)
      match {
        body        = try(probe.value.match_body, "")
        status_code = try(probe.value.match_status_code, ["200"])
      }
    }
  }

  #
  # URL path map
  #

  dynamic "url_path_map" {
    for_each = var.appgw_url_path_map
    content {
      name                               = try(url_path_map.value.name)
      default_backend_address_pool_name  = try(url_path_map.value.default_backend_address_pool_name)
      default_backend_http_settings_name = try(url_path_map.value.default_backend_http_settings_name, lookup(url_path_map.value.default_backend_address_pool_name))

      dynamic "path_rule" {
        for_each = try(url_path_map.value.path_rule)
        content {
          name                       = try(path_rule.value.path_rule_name)
          backend_address_pool_name  = try(path_rule.value.backend_address_pool_name, try(path_rule.value.path_rule_name))
          backend_http_settings_name = try(path_rule.value.backend_http_settings_name, try(path_rule.value.path_rule_name))
          paths                      = [try(path_rule.value.paths)]
        }
      }
    }
  }

  #
  # Redirect configuration
  #

  dynamic "redirect_configuration" {
    for_each = var.appgw_redirect_configuration
    content {
      name                 = try(redirect_configuration.value.name)
      redirect_type        = try(redirect_configuration.value.redirect_type, "Permanent")
      target_listener_name = try(redirect_configuration.value.target_listener_name)
      include_path         = try(redirect_configuration.value.include_path, "true")
      include_query_string = try(redirect_configuration.value.include_query_string, "true")
    }
  }

  tags = var.tags

  # Ignore most changes as they should be managed by AKS ingress controller
  lifecycle {
    ignore_changes = [
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      request_routing_rule,
      url_path_map,
      ssl_certificate,
      redirect_configuration,
      autoscale_configuration,
      tags
    ]
  }

}
