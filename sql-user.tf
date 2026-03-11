resource "null_resource" "create_db_user" {

  depends_on = [
    azurerm_container_app.backend,
    azurerm_mssql_database.db
  ]

  provisioner "local-exec" {

    command = <<EOT
az sql db query \
  --resource-group ${azurerm_resource_group.rg.name} \
  --server ${azurerm_mssql_server.sql.name} \
  --name ${azurerm_mssql_database.db.name} \
  --auth-type AD \
  --query "CREATE USER [${azurerm_container_app.backend.name}] FROM EXTERNAL PROVIDER"
EOT

  }
}
resource "null_resource" "grant_db_permissions" {

  depends_on = [null_resource.create_db_user]

  provisioner "local-exec" {

    command = <<EOT
az sql db query \
  --resource-group ${azurerm_resource_group.rg.name} \
  --server ${azurerm_mssql_server.sql.name} \
  --name ${azurerm_mssql_database.db.name} \
  --auth-type AD \
  --query "
ALTER ROLE db_datareader ADD MEMBER [${azurerm_container_app.backend.name}];
ALTER ROLE db_datawriter ADD MEMBER [${azurerm_container_app.backend.name}];
"
EOT

  }
}