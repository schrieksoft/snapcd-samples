output "login_instructions" {
  value = <<EOT
  # Log into Azure with CLI
az login
az account set --subscription ${var.subscription_id}

# Log into cluster (create kube config entry):
az aks get-credentials --name ${azurerm_kubernetes_cluster.this.name} --resource-group ${azurerm_resource_group.this.name} --subscription ${var.subscription_id}
EOT
}

output "name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "cluster_host" {
  value = azurerm_kubernetes_cluster.this.kube_admin_config.0.host
}
output "cluster_ca_certificate" {
  value = base64decode(azurerm_kubernetes_cluster.this.kube_admin_config.0.cluster_ca_certificate)
  sensitive = true
}
output "cluster_token" {
  value = yamldecode(azurerm_kubernetes_cluster.this.kube_admin_config_raw).users[0].user.token
  sensitive = true
}
output "cluster_oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.this.oidc_issuer_url
}