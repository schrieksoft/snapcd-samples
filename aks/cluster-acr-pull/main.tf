
variable "aks_cluster_kubelet_identity_object_id" {}
variable "azurecr_pull_group_ids" {}

resource "azuread_group_member" "acr_pull" {
  for_each         = toset(var.azurecr_pull_group_ids)
  group_object_id  = each.key
  member_object_id = var.aks_cluster_kubelet_identity_object_id //azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}
