Module to create web apps as per the user requirements

Usage:

module "webapp" {
    count = 3
    source              = "modules/appservice"
    name                = ${var.webappname}-${count.index}
    resource_group_name = var.resourcegroupname
    plan_settings       = {
                             kind     = "Linux" # Linux or Windows
                             size     = "S2"
                             capacity = 1
                             tier     = "Standard"
                          }
}