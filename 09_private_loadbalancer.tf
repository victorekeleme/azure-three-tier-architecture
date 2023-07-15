resource "azurerm_lb" "private_lb" {
  name                = "${local.resource_prefix}-private_lb"
  resource_group_name = azurerm_resource_group.project_rg.name
  location            = azurerm_resource_group.project_rg.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "private_lb_ip"
    subnet_id                     = azurerm_subnet.private_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    private_ip_address            = "10.0.70.50"
  }
}

resource "azurerm_lb_backend_address_pool" "private_vmss_bepool" {
  name            = "private_vmss_bepool"
  loadbalancer_id = azurerm_lb.private_lb.id
}

resource "azurerm_lb_probe" "private_vmss_probe" {
  loadbalancer_id     = azurerm_lb.private_lb.id
  name                = "lb_tcp_probe"
  port                = 80
  protocol            = "Tcp"
  interval_in_seconds = 10
  probe_threshold     = 3
  number_of_probes    = 4
}

resource "azurerm_lb_rule" "private_vmss_lb_rule" {
  name                           = "private_vmss_lb_rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  loadbalancer_id                = azurerm_lb.private_lb.id
  frontend_ip_configuration_name = azurerm_lb.private_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.private_vmss_bepool.id]
  probe_id                       = azurerm_lb_probe.private_vmss_probe.id
}
