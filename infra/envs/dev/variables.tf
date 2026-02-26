variable "location" { type = string }
variable "name_prefix" { type = string }

variable "vnet_cidr" { type = string }
variable "subnet_public_cidr" { type = string }
variable "subnet_private_cidr" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}

variable "admin_username" { type = string }
variable "ssh_public_key_path" { type = string }
variable "instance_count" { type = number }
variable "vm_sku" { type = string }
variable "container_image" { type = string }