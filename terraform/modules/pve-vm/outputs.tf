output "vm_id" {
  description = "VMID de la VM creada"
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "ipv4_address" {
  description = "IPv4 configurada por cloud-init"
  value       = var.ip_address
}
