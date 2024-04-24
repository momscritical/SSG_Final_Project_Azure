output "gateway_frontend_ip" {
  value = "http://${azurerm_public_ip.public-ip-for-agw.ip_address}"
}