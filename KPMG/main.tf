provider "azurerm" {
  features {}
}

terraform {
  required_providers {
     azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.40"
       }
     }

module "rg" {
  source = "modules/resourcegroup"

  name     = var.name
  location = var.location

  tags = var.tags
}

module "vnet" {
  source              = "modules/vnet"
  resource_group_name = module.rg.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  tags = {
	OWNER = "Manoj"
  }

}

#NSG Creation

module "network-security-group" {
  source                = "modules/nsg"
  resource_group_name   = module.rg.name
  location              = var.location
  security_group_name   = var.security_group_name
  source_address_prefix = var.source_address_prefix	# Vnetdetails
  predefined_rules = [
    {
      name     = "SSH"
      priority = "500"
    },
    {
      name              = "LDAP"
    },
   {
	name	= "MSSQL"
}
  ]

  tags = {
    Owner = "Manoj"
  }
}

#Creating appservice
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

#DatabaseCreation
module "sql-database" {
  source              = "modules/appgateway"
  resource_group_name = var.resourcegroupname
  location            = var.location
  db_name             = var.dbname
  sql_admin_username  = "mradministrator"
  sql_password        = "P@ssw0rd12345!"

  tags             = var.tags
  
}

#Application gateway

module {
  source = "modules/applicationgateway"
  version = "1.0.0"
}

inputs {
  name                = var.agwname
  resource_group_name = var.resourcegroupname
  location            = var.location
  subnet_id           = module.vnet.subnet1.id

  private_ip_address = var.ipadress

  capacity = {
    min = 1
    max = 2
  }

  zones = ["1", "2", "3"]
}
