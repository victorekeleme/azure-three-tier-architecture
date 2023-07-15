output "private_subnet_id" {
  description = "Private subnet id"
  value       = azurerm_subnet.private_subnet.id
}