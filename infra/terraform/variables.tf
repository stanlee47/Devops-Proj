variable "resource_group_name" {
  type    = string
  default = "devopsproject"
}

variable "location" {
  type    = string
  default = "centralindia"
}

variable "acr_name" {
  type    = string
  default = "taskflowproject"
  description = "Existing ACR name"
}

variable "aks_name" {
  type    = string
  default = "aks-taskflow"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "node_vm_size" {
  type    = string
  default = "Standard_B2ms"
}
