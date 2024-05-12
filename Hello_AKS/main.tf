terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
  helm = {
    source    = "hashicorp/helm"
    version   = ">= 2.12.1"
  }
  required_version = ">= 1.8"
}

provider "azurerm" {
  features {}

  use_oidc  = true
}

provider "helm" {
  kubernetes [
    config_path = var.kubeconfigfile
  ]
}

resource "azurerm_resource_group" "rg_aks" {
  name     = local.rg_name
  location = local.location

  tags = {
    environment = local.environment
  }
}