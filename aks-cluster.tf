resource "azurerm_resource_group" "example" {
  name     = "valuepoint4-rg"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "valuepoint-aks4"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "valuepoint4"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
}

output "kube_config" {
  sensitive = true
  value = azurerm_kubernetes_cluster.example.kube_config_raw
}
