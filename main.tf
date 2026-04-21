terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # To jest Twój "bezpiecznik" - stan będzie w chmurze
  backend "azurerm" {
    resource_group_name  = "rg-terraform-cloudshell"
    storage_account_name = "silentremedywesteurope01"
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
}