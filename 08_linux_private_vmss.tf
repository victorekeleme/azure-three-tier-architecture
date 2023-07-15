resource "azurerm_linux_virtual_machine_scale_set" "linux_private_vmss" {
  name                = "${local.resource_prefix}-${var.private_vmss_name}"
  resource_group_name = azurerm_resource_group.project_rg.name
  location            = azurerm_resource_group.project_rg.location
  sku                 = "Standard_DS1_v2"
  instances           = 2
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.private_admin_username
    public_key = file(var.private_key_path)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  upgrade_mode = "Automatic"

  network_interface {
    name                      = "${var.private_vmss_name}-nic"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.private_vmss_nsg.id

    ip_configuration {
      name                                   = "private"
      primary                                = true
      subnet_id                              = azurerm_subnet.private_subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.private_vmss_bepool.id]
    }
  }
}

# Network security group resource for private vmss
resource "azurerm_network_security_group" "private_vmss_nsg" {
  name                = "${local.resource_prefix}-${var.private_vmss_name}-nsg"
  resource_group_name = azurerm_resource_group.project_rg.name
  location            = azurerm_resource_group.project_rg.location

  # Network security group rule resource for vmss subnet
  dynamic "security_rule" {
    for_each = var.private_vmss_inbound_ports

    content {
      name                       = "${var.private_vmss_name}-nsg-rule-${security_rule.value}"
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