terraform {

  required_version = ">=1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.100"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "konradquiztfstate"
    container_name       = "tfstate"
    key                  = "konradquiz.terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}