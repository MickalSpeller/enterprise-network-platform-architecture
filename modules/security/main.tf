resource "azurerm_key_vault" "kv-platform-secure" {
  name                        = "kv-platform-secure"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  sku_name                    = "standard"
  purge_protection_enabled    = true
  tenant_id = data.azurerm_client_config.current.tenant_id
  
  soft_delete_retention_days = 7
  public_network_access_enabled = false 
}
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "kv-access-policy" {
  key_vault_id = azurerm_key_vault.kv-platform-secure.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]
  key_permissions = [
    "Get",
    "List",
    "Create",
    "Delete"    
  ]
}

