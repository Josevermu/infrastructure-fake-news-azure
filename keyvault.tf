resource "azurerm_key_vault" "kv" {

  name                = "konradquiz-kv-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = "standard"
}

resource "azurerm_key_vault_secret" "encryption" {

  name         = "encryption-secret"
  value        = var.encryption_secret_key
  key_vault_id = azurerm_key_vault.kv.id
}