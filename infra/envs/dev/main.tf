module "network" {
  source = "../../modules/network"

  name_prefix = var.name_prefix
  location    = var.location

  vnet_cidr           = var.vnet_cidr
  subnet_public_cidr  = var.subnet_public_cidr
  subnet_private_cidr = var.subnet_private_cidr

  tags = var.tags
}

module "lb" {
  source = "../../modules/lb"

  name_prefix = var.name_prefix
  location    = var.location
  rg_name     = module.network.rg_name
  tags        = var.tags
}


module "vmss" {
  source = "../../modules/vmss"

  name_prefix = var.name_prefix
  location    = var.location
  rg_name     = module.network.rg_name

  subnet_id       = module.network.private_subnet_id
  backend_pool_id = module.lb.backend_pool_id

  health_probe_id = module.lb.health_probe_id

  admin_username = var.admin_username
  ssh_public_key = file(var.ssh_public_key_path)
  instance_count = var.instance_count
  vm_sku         = var.vm_sku

  container_image = var.container_image

  tags = var.tags
}



module "monitoring" {
  source = "../../modules/monitoring"

  name_prefix = var.name_prefix
  location    = var.location
  rg_name     = module.network.rg_name

  vmss_id = module.vmss.vmss_id
  lb_id   = module.lb.lb_id
}
