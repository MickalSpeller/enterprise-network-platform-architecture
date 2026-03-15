resource "azurerm_resource_group" "rg-ent-observ-platform" {
  location = "eastus"
  name     = "rg-ent-observ-platform"
}

module "network" {
  source = "./modules/network"
  
  resource_group_name = azurerm_resource_group.rg-ent-observ-platform.name
  location = azurerm_resource_group.rg-ent-observ-platform.location
}

module "vpngateway" {
  source = "./modules/vpngateway"
  resource_group_name = azurerm_resource_group.rg-ent-observ-platform.name
  location = azurerm_resource_group.rg-ent-observ-platform.location
  gateway_subnet_id = module.network.gatewaysubnet_id
  shared_key = azurerm_resource_group.rg-ent-observ-platform.name
} 

module "security" {
  source = "./modules/security"
  resource_group_name = azurerm_resource_group.rg-ent-observ-platform.name
  location = azurerm_resource_group.rg-ent-observ-platform.location
  keyvault_name = "kv-platform-secure"
  secrets = {
    "shared_key" = "P@ssw0rd1234"
}
}
