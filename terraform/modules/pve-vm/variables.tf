variable "name" {
  description = "Nombre de la VM"
  type        = string
}

variable "vm_id" {
  description = "VMID numérico dentro de Proxmox"
  type        = number
}

variable "node_name" {
  description = "Nodo Proxmox donde se crea la VM"
  type        = string
}

variable "template_vm_id" {
  description = "VMID del template desde el que se clona"
  type        = number
}

variable "cores" {
  description = "Cantidad de vCPU"
  type        = number
  default     = 2
}

variable "memory_mb" {
  description = "Memoria RAM en MB"
  type        = number
  default     = 2048
}

variable "disk_gb" {
  description = "Tamaño del disco principal en GB"
  type        = number
  default     = 20
}

variable "datastore_id" {
  description = "Datastore para el disco y el cloud-init"
  type        = string
  default     = "local-lvm"
}

variable "bridge" {
  description = "Bridge de red de Proxmox"
  type        = string
  default     = "vmbr0"
}

variable "ip_address" {
  description = "Dirección IPv4 con prefijo, por ejemplo 10.10.10.11/24"
  type        = string
}

variable "gateway" {
  description = "Gateway IPv4 de la red"
  type        = string
}

variable "dns_servers" {
  description = "Servidores DNS"
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "tags" {
  description = "Tags de Proxmox"
  type        = list(string)
  default     = []
}

variable "ssh_public_key" {
  description = "Clave pública inyectada por cloud-init"
  type        = string
}

variable "cloud_init_user" {
  description = "Usuario creado por cloud-init"
  type        = string
  default     = "platform"
}
