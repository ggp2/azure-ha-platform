data "template_file" "cloud_init" {
  template = file("${path.module}/cloud-init.yml.tftpl")
  vars = {
    container_image = var.container_image
  }
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "${var.name_prefix}-vmss"
  location            = var.location
  resource_group_name = var.rg_name

  sku       = var.vm_sku
  instances = var.instance_count

  admin_username = var.admin_username
  upgrade_mode   = "Manual" # simple et stable pour l'étape 4

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "${var.name_prefix}-nic"
    primary = true

    ip_configuration {
      name                                  = "ipcfg"
      primary                               = true
      subnet_id                             = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.backend_pool_id]
    }
  }

  custom_data = base64encode(data.template_file.cloud_init.rendered)

  tags = var.tags
}