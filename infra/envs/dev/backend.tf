terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "ggp2tfstate67843"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}