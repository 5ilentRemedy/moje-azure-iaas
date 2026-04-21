locals {
  common_tags = {
    Project     = "Nauka Terraform"
    Environment = "Dev"
    Owner       = "5ilentRemedy"
  }
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-cloudshell"
    storage_account_name = "silentremedybasic01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_nauka" {
  name     = "rg-terraform-cloudshell"
  location = "francecentral"
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-nauka"
  address_space       = ["10.0.0.0/16"]
  location            = "francecentral"
  resource_group_name = azurerm_resource_group.rg_nauka.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg_nauka.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "location" {
  type    = string
  default = "francecentral"
}
