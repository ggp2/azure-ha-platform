variable "name_prefix" { type = string }
variable "location" { type = string }
variable "rg_name" { type = string }

variable "subnet_id" { type = string }
variable "backend_pool_id" { type = string }

variable "admin_username" { type = string }
variable "ssh_public_key" { type = string }

variable "instance_count" { type = number }
variable "vm_sku" { type = string }

variable "container_image" { type = string }

variable "tags" { type = map(string) }

variable "health_probe_id" { type = string }