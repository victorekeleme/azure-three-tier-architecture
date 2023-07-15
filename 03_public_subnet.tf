# azure public subnet resource
resource "azurerm_subnet" "public_subnet" {
  name                 = "${local.resource_prefix}-${var.public_subnet_name}"
  resource_group_name  = azurerm_resource_group.project_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnet_address_space[0]]
}

# Public route table 
resource "azurerm_route_table" "public_subnet_rtb" {
  name                = "${local.resource_prefix}-${var.public_subnet_name}-rtb"
  resource_group_name = azurerm_resource_group.project_rg.name
  location            = azurerm_resource_group.project_rg.location

  route {
    name           = "internet_route"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  tags = local.common_tags
}

# Subnet and route table association
resource "azurerm_subnet_route_table_association" "public_subnet_rtb_asc" {
  depends_on = [azurerm_subnet.public_subnet]

  subnet_id      = azurerm_subnet.public_subnet.id
  route_table_id = azurerm_route_table.public_subnet_rtb.id
}

# Subnet and network security group association
resource "azurerm_subnet_network_security_group_association" "public_subnet_nsg_asc" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.public_subnet_nsg.id
}

# Network security group resource for public subnet
resource "azurerm_network_security_group" "public_subnet_nsg" {
  name                = "${local.resource_prefix}-${var.public_subnet_name}-nsg"
  resource_group_name = azurerm_resource_group.project_rg.name
  location            = azurerm_resource_group.project_rg.location

  # Network security group rule resource for public subnet
  dynamic "security_rule" {
    for_each = var.public_subnet_inbound_ports

    content {
      name                       = "${var.public_subnet_name}-nsg-rule-${security_rule.value}"
      priority                   = sum([100, security_rule.key])
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

