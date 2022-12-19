
output "resource_group_name" {
  value = azurerm_resource_group.azure-jenkins-rg.name
}

output "output-public_ip_1_address" {
  #value = data.azurerm_public_ip.data-public_ip_1.ip_address
  value = azurerm_linux_virtual_machine.azure-linux_virtual_machine-1.public_ip_address
}

output "output-net_int_1_mac-address" {
  value = azurerm_network_interface.azure-net_int-1.mac_address
}

#output "tls_private_key" {
#  value     = tls_private_key.ssh_key-1.private_key_pem
#  sensitive = true
#}