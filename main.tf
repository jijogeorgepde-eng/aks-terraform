terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = "~> 4.0"
    }

  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
  subscription_id = "a2b28c85-1948-4263-90ca-bade2bac4df4"
}

data "azurerm_resource_group" "myrg" {
  name = var.rg
}


resource "azurerm_virtual_network" "myvnet" {
  name                = "vnet-jfoods-dev"
  resource_group_name = data.azurerm_resource_group.myrg.name
  location            = var.location
  address_space       = ["10.10.0.0/16"]
}
