
/////////////////////////////////////////////////////////////////
// Resource Group
/////////////////////////////////////////////////////////////////

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}


resource "azurerm_kubernetes_cluster" "this" {

  name                              = var.name
  location                          = azurerm_resource_group.this.location
  resource_group_name               = azurerm_resource_group.this.name
  node_resource_group               = "${azurerm_resource_group.this.name}-nodes"
  kubernetes_version                = var.kubernetes_version
  sku_tier                          = "Free"
  oidc_issuer_enabled               = true
  default_node_pool {
    name                         = "system"
    only_critical_addons_enabled = true
    orchestrator_version         = var.kubernetes_version
    zones                        = ["1", "2"]
    type                         = "VirtualMachineScaleSets"
    vnet_subnet_id               = var.ingress_subnet_id
    pod_subnet_id                = var.apps_subnet_id
    enable_auto_scaling          = var.enable_auto_scaling
    enable_host_encryption       = var.enable_host_encryption
    enable_node_public_ip        = var.enable_node_public_ip
    min_count                    = var.min_count
    max_count                    = var.max_count
    os_disk_size_gb              = var.os_disk_size_gb
    vm_size                      = var.vm_size
  }
}
