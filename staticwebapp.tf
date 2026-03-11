resource "azurerm_static_web_app" "frontend" {

  name                = "konradquiz-frontend-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_tier = "Free"
  sku_size = "Free"
}