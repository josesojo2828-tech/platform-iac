module "pve_vm" {
  source   = "./modules/pve-vm"
  for_each = var.hosts

  name            = each.key
  vm_id           = each.value.vm_id
  node_name       = each.value.node_name
  template_vm_id  = each.value.template_vm_id
  cores           = each.value.cores
  memory_mb       = each.value.memory_mb
  disk_gb         = each.value.disk_gb
  datastore_id    = each.value.datastore_id
  bridge          = each.value.bridge
  ip_address      = each.value.ip_address
  gateway         = each.value.gateway
  dns_servers     = each.value.dns_servers
  tags            = each.value.tags
  ssh_public_key  = var.ssh_public_key
  cloud_init_user = "platform"
}
