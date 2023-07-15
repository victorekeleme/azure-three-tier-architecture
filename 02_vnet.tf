# Virtual network resource
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.resource_prefix}-vnet"
  resource_group_name = azurerm_resource_group.project_rg.name
  location            = azurerm_resource_group.project_rg.location
  address_space       = var.vnet_address_space

  tags = local.common_tags
}