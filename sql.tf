resource "azurerm_mssql_server" "sql" {

  name                         = "konradquiz-sql-${var.environment}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = "12.0"

  administrator_login          = "sqladminuser"
  administrator_login_password = var.admin_password
}

resource "azurerm_mssql_database" "db" {

  name      = "konradquiz"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "Basic"
}

resource "azurerm_mssql_firewall_rule" "allow_azure" {

  name      = "AllowAzureServices"
  server_id = azurerm_mssql_server.sql.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}