variable "proxmox_endpoint" {
  description = "URL de la API de Proxmox, por ejemplo https://pve.example.com:8006/"
  type        = string
}

variable "proxmox_api_token" {
  description = "API token con formato user@realm!tokenid=secret"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Aceptar certificados TLS autofirmados del nodo Proxmox"
  type        = bool
  default     = false
}

variable "proxmox_ssh_user" {
  description = "Usuario SSH que Terraform usa para operaciones fuera de la API"
  type        = string
  default     = "root"
}

variable "ssh_public_key" {
  description = "Clave pública inyectada por cloud-init en cada VM"
  type        = string
}

variable "hosts" {
  description = "Mapa de VMs a crear, indexado por nombre"
  type = map(object({
    vm_id          = number
    node_name      = string
    template_vm_id = number
    cores          = number
    memory_mb      = number
    disk_gb        = number
    datastore_id   = string
    bridge         = string
    ip_address     = string
    gateway        = string
    dns_servers    = list(string)
    tags           = list(string)
  }))
}
