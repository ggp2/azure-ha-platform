output "rg_name" { value = module.network.rg_name }
output "vnet_id" { value = module.network.vnet_id }
output "private_subnet_id" { value = module.network.private_subnet_id }
output "public_subnet_id" { value = module.network.public_subnet_id }

output "lb_public_ip" {
  value = module.lb.lb_public_ip
}

output "lb_backend_pool_id" {
  value = module.lb.backend_pool_id
}

output "lb_health_probe_id" {
  value = module.lb.health_probe_id
}

output "vmss_name" { value = module.vmss.vmss_name }