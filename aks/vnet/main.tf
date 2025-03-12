
locals {
  
  subnet_ids = {
    "apps" : azurerm_subnet.apps.id
    "ingress" : azurerm_subnet.ingress.id
  }

  subnet_cidrs = {
    "apps" : azurerm_subnet.apps.id
    "ingress" : azurerm_subnet.ingress.id
  }
}

/////////////////////////////////////////////////////////////////
// Virtual Network and Subnets
//////////////////////////////////////////////////////////////////

resource "azurerm_virtual_network" "this" {
  name                = local.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.networking.apps_cidr, var.networking.ingress_cidr, var.networking.postgres_subnet_cidr]
  dns_servers         = [var.networking.firewall_private_ip_address]
}

resource "azurerm_subnet" "apps" {
  name                 = "apps"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.networking.apps_cidr]
  service_endpoints = [
    "Microsoft.Sql",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Storage",
  ]
  lifecycle {
    ignore_changes = [
      delegation,
    ]
  }
}

resource "azurerm_subnet" "ingress" {
  name                 = "ingress"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.networking.ingress_cidr]
}

resource "azurerm_route_table" "ingress" {
  name                = "ingress"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_route" "ingress" {
  name                = "ingress"
  resource_group_name = azurerm_resource_group.this.name
  route_table_name    = azurerm_route_table.ingress.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "Internet"
}

resource "azurerm_subnet_route_table_association" "ingress" {
  subnet_id      = azurerm_subnet.ingress.id
  route_table_id = azurerm_route_table.ingress.id
}


