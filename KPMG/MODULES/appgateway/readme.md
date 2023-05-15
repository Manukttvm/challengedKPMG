Application Gateway

This module deploys a simple app gatewat with waf enabled

Usage
To create a simple application gateway deployed with tau.

module {
  source = "modules/appgateway"
  version = "1.0.0"
}

inputs {
  name                = var.name
  resource_group_name = var.rsgname
  location            = var.location
  subnet_id           = var.subnetid

  private_ip_address = "var.ip

  capacity = {
    min = 1
    max = 2
  }

  zones = ["1", "2", "3"]
}