resource "azurerm_resource_group" "project_rg" {
  location = var.resource_group_location
  name     = "${local.resource_prefix}-rg"
}