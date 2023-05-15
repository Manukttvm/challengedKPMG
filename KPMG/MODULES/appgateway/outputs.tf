output "appgw_id" {
  description = "AGW ID"
  value       = azurerm_application_gateway.app_gateway.id
}

output "appgw_name" {
  description = "AGW Name"
  value       = azurerm_application_gateway.app_gateway.name
}

output "appgw_subnet_id" {
  description = "Gatewaysubnetid"
  value       = azurerm_application_gateway.app_gateway.subnet.id
}

output "appgw_public_ip_address" {
  description = " public IP address "
  value       = azurerm_public_ip.ip.ip_address
}

output "appgw_backend_address_pool_ids" {
  description = " backend address pool Ids."
  value       = azurerm_application_gateway.app_gateway.backend_address_pool.*.id
}

output "appgw_backend_http_settings_ids" {
  description = "Backend HTTP "
  value       = azurerm_application_gateway.app_gateway.backend_http_settings.*.id
}

output "appgw_frontend_ip_configuration_ids" {
  description = "frontend IP configuration Ids."
  value       = azurerm_application_gateway.app_gateway.frontend_ip_configuration.*.id
}

output "appgw_frontend_port_ids" {
  description = " frontend port Ids."
  value       = azurerm_application_gateway.app_gateway.frontend_port.*.id
}