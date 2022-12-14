
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip

output "output-public_ip_1_address" {
  value = data.azurerm_public_ip.data-public_ip_1.ip_address
}