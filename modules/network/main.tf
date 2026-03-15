resource "azurerm_virtual_network" "vnet-hub-secure" {
  name                = "vnet-hub-secure"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}
resource "azurerm_subnet" "azurefirewallsubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub-secure.name
  address_prefixes     = ["10.0.0.0/24"]
}
resource "azurerm_subnet" "gatewaysubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub-secure.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "sharedservicessubnet" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub-secure.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_subnet" "managementsubnet" {
  name                 = "ManagementSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub-secure.name
  address_prefixes     = ["10.0.3.0/24"]
}
resource "azurerm_virtual_network" "vnet-spoke-secure" {
  name                = "vnet-spoke-secure"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}
resource "azurerm_subnet" "appsubnet" {
  name                 = "AppSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-secure.name
  address_prefixes     = ["10.1.0.0/24"]
}
resource "azurerm_virtual_network_peering" "hub-to-spoke" {
  name                      = "hub-to-spoke"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet-hub-secure.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-spoke-secure.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
  allow_virtual_network_access = true
}
resource "azurerm_virtual_network_peering" "spoke-to-hub" {
  name                      = "spoke-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet-spoke-secure.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-hub-secure.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  allow_virtual_network_access = true
}
