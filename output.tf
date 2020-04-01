output "DC_ID" {
  description = "id of vSphere Datacenter"
  value       = data.vsphere_datacenter.dc.id
}


output "Windows-VM" {
  description = "VM Names"
  value       = vsphere_virtual_machine.windows.*.name
}

output "Windows-ip" {
  description = "default ip address of the deployed VM"
  value       = vsphere_virtual_machine.windows.*.default_ip_address
}

output "Windows-guest-ip" {
  description = "all the registered ip address of the VM"
  value       = vsphere_virtual_machine.windows.*.guest_ip_addresses
}

output "Windows-uuid" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.windows.*.uuid
}

output "Linux-VM" {
  description = "VM Names"
  value       = vsphere_virtual_machine.linux.*.name
}

output "Linux-ip" {
  description = "default ip address of the deployed VM"
  value       = vsphere_virtual_machine.linux.*.default_ip_address
}

output "Linux-guest-ip" {
  description = "all the registered ip address of the VM"
  value       = vsphere_virtual_machine.linux.*.guest_ip_addresses
}

output "Linux-uuid" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.linux.*.uuid
}