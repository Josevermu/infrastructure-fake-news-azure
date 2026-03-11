output "backend_url" {
  value = azurerm_container_app.backend.latest_revision_fqdn
}

output "frontend_url" {
  value = azurerm_static_web_app.frontend.default_host_name
}

output "sql_server" {
  value = azurerm_mssql_server.sql.name
}