
This module creates Azure Resource Group.


## Application

main.tf
provider "azurerm" {
  features {}
}

module "rg" {
  source = "modules/resourcegroup"

  name     = "RSGTHREETIER"
  location = "East US"

  tags = {
    OWNER = "Manoj"
  }
}

```

## Pre-Requisites

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| azurerm | >= 2.41.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.41.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) |

