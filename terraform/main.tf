variable "oidc_request_token" {}
variable "oidc_request_url" {}

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
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

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id    = "70d5e864-9f03-4df8-85f7-5f81492a320d"
  client_id          = "b3e51ce2-c34f-47c2-bb74-e6483d63d5f3"
  use_oidc           = true
  oidc_request_token = var.oidc_request_token
  oidc_request_url   = var.oidc_request_url
  tenant_id          = "226acfa5-fb1c-4244-a97b-cc0f92cd518d"
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