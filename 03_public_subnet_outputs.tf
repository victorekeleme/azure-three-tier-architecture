output "public_subnet_id" {
  description = "Public subnet id"
  value       = azurerm_subnet.public_subnet.id
}