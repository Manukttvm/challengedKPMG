
resource "azurerm_network_security_group" "nsg" {
  name                = var.security_group_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.nsg.name
  tags                = var.tags
}

#############################
#   Simple security rules   #
#############################

resource "azurerm_network_security_rule" "predefined_rules" {
  count                                      = length(var.predefined_rules)
  name                                       = lookup(var.predefined_rules[count.index], "name")
  priority                                   = lookup(var.predefined_rules[count.index], "priority", 4096 - length(var.predefined_rules) + count.index)
  direction                                  = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 0)
  access                                     = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 1)
  protocol                                   = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 2)
  source_port_range                          = lookup(var.predefined_rules[count.index], "source_port_range", "*") == "*" ? "*" : null
  source_port_ranges                         = lookup(var.predefined_rules[count.index], "source_port_range", "*") == "*" ? null : split(",", var.predefined_rules[count.index].source_port_range)
  destination_port_range                     = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 4)
  description                                = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 5)
  source_address_prefix                      = lookup(var.predefined_rules[count.index], "source_application_security_group_ids", null) == null && var.source_address_prefixes == null ? join(",", var.source_address_prefix) : null
  source_address_prefixes                    = lookup(var.predefined_rules[count.index], "source_application_security_group_ids", null) == null ? var.source_address_prefixes : null
  destination_address_prefix                 = lookup(var.predefined_rules[count.index], "destination_application_security_group_ids", null) == null && var.destination_address_prefixes == null ? join(",", var.destination_address_prefix) : null
  destination_address_prefixes               = lookup(var.predefined_rules[count.index], "destination_application_security_group_ids", null) == null ? var.destination_address_prefixes : null
  resource_group_name                        = data.azurerm_resource_group.nsg.name
  network_security_group_name                = azurerm_network_security_group.nsg.name
  source_application_security_group_ids      = lookup(var.predefined_rules[count.index], "source_application_security_group_ids", null)
  destination_application_security_group_ids = lookup(var.predefined_rules[count.index], "destination_application_security_group_ids", null)
}