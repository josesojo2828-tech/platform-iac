output "vm_ids" {
  description = "VMID asignado a cada host"
  value       = { for name, vm in module.pve_vm : name => vm.vm_id }
}

output "vm_ips" {
  description = "Dirección IPv4 configurada por cloud-init en cada host"
  value       = { for name, vm in module.pve_vm : name => vm.ipv4_address }
}
