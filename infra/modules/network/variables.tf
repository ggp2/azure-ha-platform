variable "name_prefix" { type = string }
variable "location" { type = string }

variable "vnet_cidr" { type = string }
variable "subnet_public_cidr" { type = string }
variable "subnet_private_cidr" { type = string }

variable "tags" { type = map(string) }