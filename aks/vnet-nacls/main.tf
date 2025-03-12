
/////////////////////////////////////////////////////////////////
// NACLS
/////////////////////////////////////////////////////////////////


resource "azurerm_network_security_group" "inbound" {
  name                = "${local.name}-inbound"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

   security_rule {
      name                       = "allow-ssh"
      priority                   = "600"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }

   security_rule {
      name                       = "allow-https"
      priority                   = "601"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }

   security_rule {
      name                       = "allow-http"
      priority                   = "602"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }


}

resource "azurerm_subnet_network_security_group_association" "apps" {
  subnet_id                 = azurerm_subnet.apps.id
  network_security_group_id = azurerm_network_security_group.inbound.id
}
resource "azurerm_subnet_network_security_group_association" "ingress" {
  subnet_id                 = azurerm_subnet.ingress.id
  network_security_group_id = azurerm_network_security_group.inbound.id
}

