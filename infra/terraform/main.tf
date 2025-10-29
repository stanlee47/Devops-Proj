terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
  }
  required_version = ">= 1.2.0"
}

provider "azurerm" {
  features {}
}

# Use existing Resource Group (data source)
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Use existing ACR (data source)
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Create AKS (will run in the existing resource group)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "${var.aks_name}-dns"

  default_node_pool {
    name       = "agentpool"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  depends_on = []
}

# Give the AKS managed identity permission to pull images from the existing ACR
resource "azurerm_role_assignment" "acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
