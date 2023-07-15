output "database_subnet_id" {
  description = "database subnet id"
  value       = azurerm_subnet.database_subnet.id
}