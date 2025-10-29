output "resource_group" {
  value = data.azurerm_resource_group.rg.name
}
output "acr_login_server" {
  value = data.azurerm_container_registry.acr.login_server
}
output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}
