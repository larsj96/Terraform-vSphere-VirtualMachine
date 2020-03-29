resource "vsphere_virtual_machine" "linux" {
  count             = var.is_windows_image ? 1 : 0
  name              = var.vm_name
  resource_pool_id  = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id      = data.vsphere_datastore.datastore.id

  num_cpus = var.vcpu_count
  memory   = var.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      #https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html#linux-customization-options
      linux_options {
        host_name = var.vm_name
        domain    = var.domain_name
      }

      network_interface {}

      /*
      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = var.vm_cidr
    }
      ipv4_gateway = var.default_gw
      dns_server_list = ["1.2.3.4"]
    */

    }

  }
}

resource "vsphere_virtual_machine" "windows" {
  count = var.is_windows_image ? 1 : 0
  name              = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vcpu_count
  memory   = var.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      #https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html#windows-customization-options
      windows_options {
        computer_name  = var.vm_name
        admin_password = var.adminpassword
        /*
        join_domain = "cloud.local"
	      domain_admin_user = "administrator@cloud.local"
	      domain_admin_password = "password"
        run_once_command_list = [

        ]
        */
      }
      network_interface {}

      /*
      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = var.vm_cidr
      }
      ipv4_gateway = var.default_gw
      dns_server_list = ["1.2.3.4"]
      */
    }
  }
}

