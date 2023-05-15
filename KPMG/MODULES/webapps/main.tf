
resource "azurerm_app_service_plan" "webserviceplan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resourcegroupname
  
  kind                = var.plan_settings["kind"]
  
  sku {
    tier     = var.plan_settings["tier"]
    size     = var.plan_settings["size"]
    capacity = var.plan_settings["capacity"]
  }
}

resource "azurerm_app_service" "webapp" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resourcegroupname
  app_service_plan_id = azurerm_app_service_plan.webserviceplan.id
  site_config         = var.site_config
  app_settings        = var.app_settings
}