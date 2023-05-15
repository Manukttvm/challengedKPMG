
This Terraform module creates a basic Azure SQL Database.

Usage
module "sql-database" {
  source              = "modules/sql"
  resource_group_name = "app1"
  location            = "eastus"
  db_name             = "db1"
  sql_admin_username  = "mradministrator"
  sql_password        = "p!@ssw0rd12256!"

  tags             = {
                        environment = "Prd"
                        costcenter  = "Dev"
                      }
  
}
