terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 2.22"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.11.2"
    }
    external = {
      source  = "hashicorp/external"
      version = ">= 2.3.3"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "linode" {
  token = var.linode_api_key
}