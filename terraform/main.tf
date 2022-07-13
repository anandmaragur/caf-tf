terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.7.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-resource-group"
    storage_account_name = "tfstrgact2"
    container_name       = "caf-tf-state"
    key                  = "caf-tf-state.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.4.2"

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