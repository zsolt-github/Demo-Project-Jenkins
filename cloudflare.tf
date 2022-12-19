# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs

resource "cloudflare_record" "cloudflare-a_record_jenkins" {
  zone_id    = var.cloudflare_zone_id
  name       = "jenkins"
  value      = azurerm_linux_virtual_machine.azure-linux_virtual_machine-1.public_ip_address
  type       = "A"
  proxied    = false
  
  depends_on = [azurerm_public_ip.azure-public_ip-1]
}