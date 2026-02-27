location    = "northeurope"
name_prefix = "ha-dev"

vnet_cidr           = "10.10.0.0/16"
subnet_public_cidr  = "10.10.1.0/24"
subnet_private_cidr = "10.10.2.0/24"

tags = {
  project     = "azure-ha-platform"
  environment = "dev"
}

admin_username = "azureuser"

ssh_public_key_path = "C:/Users/provi/.ssh/id_rsa_azure_ha.pub"

instance_count = 2
vm_sku         = "Standard_D2s_v6"

container_image = "ghcr.io/ggp2/azure-ha-platform:latest"