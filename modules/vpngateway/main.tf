resource "azurerm_resource_group" "rg-ent-observ-platform" {
  location = "eastus"
  name     = "rg-ent-observ-platform"
}
resource "azurerm_subnet" "gatewaysubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg-ent-observ-platform.name
  virtual_network_name = azurerm_virtual_network.vnet-hub-secure.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_virtual_network" "vnet-hub-secure" {
  name                = "vnet-hub-secure"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-ent-observ-platform.location
  resource_group_name = azurerm_resource_group.rg-ent-observ-platform.name
}

resource "azurerm_local_network_gateway" "onprem-gw" {
  name                = "onprem-gw"
  location            = azurerm_resource_group.rg-ent-observ-platform.location
  resource_group_name = azurerm_resource_group.rg-ent-observ-platform.name
  gateway_address     = var.onprem_gateway_ip
  address_space       = var.address_space
}
resource "azurerm_virtual_network_gateway_connection" "vpn-connection" {
  name                = "vpn-connection-to-onprem"
  location            = azurerm_resource_group.rg-ent-observ-platform.location
  resource_group_name = azurerm_resource_group.rg-ent-observ-platform.name
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn-gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem-gw.id
  type                        = "IPsec"

  shared_key                  = var.shared_key
  enable_bgp                  = false
  
  ipsec_policy {
    dh_group = var.dh_group
    ike_encryption = var.ike_encryption
    ike_integrity = var.ike_integrity
    ipsec_encryption = var.ipsec_encryption
    ipsec_integrity = var.ipsec_integrity
    pfs_group = var.pfs_group
  }
}
resource "azurerm_virtual_network_gateway" "vpn-gateway" {
  name                = "vpn-gateway"
  location            = azurerm_resource_group.rg-ent-observ-platform.location
  resource_group_name = azurerm_resource_group.rg-ent-observ-platform.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn-gateway-pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gatewaysubnet.id
  }
}
resource "azurerm_public_ip" "vpn-gateway-pip" {
  name                = "vpn-gateway-pip"
  location            = azurerm_resource_group.rg-ent-observ-platform.location
  resource_group_name = azurerm_resource_group.rg-ent-observ-platform.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
