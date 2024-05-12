terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
  required_version = ">= 1.8"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name      = "test"
  location  = "West US 2"

  provisioner "local-exec" {
    command = "echo ${self.name} > output.txt"
  }
}