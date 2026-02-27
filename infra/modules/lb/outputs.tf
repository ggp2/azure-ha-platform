output "lb_public_ip" {
  value = azurerm_public_ip.lb_pip.ip_address
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.bepool.id
}

output "health_probe_id" {
  value = azurerm_lb_probe.http.id
}


output "lb_id" {
  value = azurerm_lb.lb.id
}
