output "gatewaysubnet_id" {
  value = azurerm_subnet.gatewaysubnet.id
}
output "vnet_id" {
  value = azurerm_virtual_network.vnet-hub-secure.id
}
/*
output "local_network_gateway_id" {
  value = azurerm_local_network_gateway.onprem-gw.id
}
output "vpn_gateway_connection_id" {
  value = azurerm_virtual_network_gateway_connection.vpn-connection.id
}
output "vpn_gateway_id" {
  value = azurerm_virtual_network_gateway.vpn-gateway.id
}

output "vpn_gateway_public_ip_id" {
  value = azurerm_public_ip.vpn-gateway-pip.id
}
*/