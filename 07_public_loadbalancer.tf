# public Ip Address
resource "azurerm_public_ip" "public_lb_ip" {
  name                = "${local.resource_prefix}-public-lb-ip"
  resource_group_name = azurerm_resource_group.project_rg.name
  location            = azurerm_resource_group.project_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "public-vm-${random_string.random.result}"

  tags = local.common_tags
}


resource "azurerm_lb" "public_lb" {
  name                = "${local.resource_prefix}-public_lb"
  resource_group_name = azurerm_resource_group.project_rg.name
  location            = azurerm_resource_group.project_rg.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "public_lb_ip"
    public_ip_address_id = azurerm_public_ip.public_lb_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "public_vmss_bepool" {
  name            = "public_vmss_bepool"
  loadbalancer_id = azurerm_lb.public_lb.id
}

resource "azurerm_lb_probe" "public_vmss_probe" {
  loadbalancer_id     = azurerm_lb.public_lb.id
  name                = "lb_tcp_probe"
  port                = 80
  protocol            = "Tcp"
  interval_in_seconds = 10
  probe_threshold     = 3
  number_of_probes    = 4
}

resource "azurerm_lb_rule" "public_vmss_lb_rule" {
  name                           = "public_vmss_lb_rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  loadbalancer_id                = azurerm_lb.public_lb.id
  frontend_ip_configuration_name = azurerm_lb.public_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.public_vmss_bepool.id]
  probe_id                       = azurerm_lb_probe.public_vmss_probe.id

}

# resource "azurerm_network_interface_backend_address_pool_association" "linuxvm_lb_nic_asc" {
#   for_each                = var.linuxvm_instance_count
#   network_interface_id    = azurerm_network_interface.linuxvm-nic[each.key].id
#   ip_configuration_name   = azurerm_network_interface.linuxvm-nic[each.key].ip_configuration[0].name
#   backend_address_pool_id = azurerm_lb_backend_address_pool.linuxvm_lb_backend_pool.id
# }