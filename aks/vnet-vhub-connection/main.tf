resource "azurerm_virtual_hub_connection" "vnet_connection" {
  depends_on = [
    azurerm_subnet.apps,
    azurerm_subnet.ingress,
  ]
  # this has to deploy to the same subscription as where the VWAN is
  name                      = local.name
  virtual_hub_id            = var.networking.virtual_hub_id
  remote_virtual_network_id = azurerm_virtual_network.this.id
  internet_security_enabled = true
  routing {
    associated_route_table_id = "${var.networking.virtual_hub_id}/hubRouteTables/defaultRouteTable"
    propagated_route_table {
      route_table_ids = [
        "${var.networking.virtual_hub_id}/hubRouteTables/noneRouteTable"
      ]
      labels = [
        "none"
      ]
    }
  }
}