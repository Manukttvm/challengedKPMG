
#
# Public IP
#

resource "azurerm_public_ip" "main" {
  name                = "${var.name}-pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

#
# Application Gateway
#

resource "azurerm_application_gateway" "main" {
  name                = "${var.name}-appgw"
  resource_group_name = var.resourcegroupname
  location            = var.location
  enable_http2        = true
  zones               = var.zones
  firewall_policy_id  = azurerm_web_application_firewall_policy.main.id

  tags = local.merged_tags

  sku {
    name = var.sku_name
    tier = var.sku_tier
  }

  autoscale_configuration {
    min_capacity = var.capacity.min
    max_capacity = var.capacity.max
  }

  identity {
    type         = "SystemAssigned""
  }

  gateway_ip_configuration {
    name      = "${var.name}-gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "${var.frontend_ip_configuration_name}-public"
    public_ip_address_id = azurerm_public_ip.main.id
  }

  frontend_ip_configuration {
    name                          = "${var.frontend_ip_configuration_name}-private"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    subnet_id                     = var.subnet_id
  }

  frontend_port {
    name = "${local.frontend_port_name}-80"
    port = 80
  }

  frontend_port {
    name = "${var.frontend_port_name}-443"
    port = 443
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/ping/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = "${var.frontend_ip_configuration_name}-private"
    frontend_port_name             = "${var.frontend_port_name}-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = var.ssl_policy_name
  }

  waf_configuration {
    enabled                  = var.waf_enabled
  }

  }

  }
}

resource "azurerm_web_application_firewall_policy" "main" {
  name                = var.policyname
  resource_group_name = var.resourcegroupname
  location            = var.location

  tags = var.tags

  policy_settings {
    enabled                     = var.waf_enabled
    request_body_check          = true
  }

      }
    }
  }

}