resource "azurerm_container_app_environment" "env" {

  name                = "konradquiz-env"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_container_app" "backend" {

  name                         = "konradquiz-backend-${var.environment}"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  identity {
    type = "SystemAssigned"
  }

  secret {
    name  = "ghcr-password"
    value = var.ghcr_token
  }

  registry {
    server               = "ghcr.io"
    username             = var.ghcr_username
    password_secret_name = "ghcr-password"
  }

  template {

    container {

      name  = "backend"
      image = var.backend_image

      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "AZURE_SQL_URL"
        value = "jdbc:sqlserver://${azurerm_mssql_server.sql.name}.database.windows.net:1433;database=${azurerm_mssql_database.db.name};authentication=ActiveDirectoryManagedIdentity"
      }

    }

  }

}

  ingress {

    external_enabled = true
    target_port      = 8080

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }

  }

}

