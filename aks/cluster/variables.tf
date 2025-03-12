variable "cluster_name" {}

variable "acr_token_dev" { sensitive = true }

variable "acr_token_prod" { sensitive = true }

variable "k8s_administrator_object_ids" {}

variable "location" {}

variable "akv_administrator_object_ids" {}

variable "private_dns_zone_name" {}

variable "subscription_id" {}

variable "tenant_id" {}

variable "system_node_pool" {
  type = object({
    enable_auto_scaling    = bool
    enable_node_public_ip  = bool
    enable_host_encryption = bool
    min_count              = number
    max_count              = number
    max_pods               = number
    os_disk_size_gb        = number
    vm_size                = string
    }
  )
}

variable "user_node_pools" {
  type = map(object({
    enable_auto_scaling    = bool
    enable_node_public_ip  = bool
    enable_host_encryption = bool
    min_count              = number
    max_count              = number
    max_pods               = number
    node_count             = number
    os_disk_size_gb        = number
    vm_size                = string
    node_taints            = list(string)
    node_labels            = map(string)
    priority               = string
    spot_max_price         = number
    subnet_name            = string
    eviction_policy        = string
    }
  ))
}


variable "networking" {
  type = object({
    apps_cidr                   = string
    ingress_cidr                = string
    service_cidr                = string
    docker_bridge_cidr          = string
    postgres_subnet_cidr        = string
    virtual_hub_id              = string
    dns_resolver_vnet_id        = string
    firewall_private_ip_address = string
  })
}



variable "azurecr_pull_group_ids" { type = list(string) }
variable "kubernetes_version" { type = string }


