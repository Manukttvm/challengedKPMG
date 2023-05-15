

Module deploys a Network Security Group (NSG) in Azure and attach it to the specified vnets.

Usage:

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}

module "network-security-group" {
  source                = "modules/nsg"
  resource_group_name   = var.resourcegroupname
  location              = "EastUS"
  security_group_name   = "netsecgrp"
  source_address_prefix = var.ipaddress
  predefined_rules = [
 
  ]


  tags = {
    environment = "dev"
    costcenter  = "it"
  }


}
