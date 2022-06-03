provider "azurerm" {
  version = "~> 2.55.0"
  features {}

}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-resource-group"
    storage_account_name = "tfstrgact"
    container_name       = "caf-tf-state"
    key                  = "caf-tf-state.tfstate"
  }
}
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.3.11"

  global_settings = var.global_settings
  resource_groups = var.resource_groups
  keyvaults       = var.keyvaults

  compute = {
    virtual_machines = var.virtual_machines
  }

  networking = {
    public_ip_addresses = var.public_ip_addresses
    vnets               = var.vnets
  }
}