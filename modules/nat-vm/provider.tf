terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.64.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.3.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.28.0"
    }
  }
}

provider "azurerm" {
  features {}
}
