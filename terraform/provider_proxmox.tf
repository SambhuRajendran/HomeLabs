terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc8"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token" {
  type = string
}
provider "proxmox" {
  pm_api_url          = variable.proxmox_api_url
  pm_api_token_id     = variable.proxmox_api_token_id
  pm_api_token_secret = variable.proxmox_api_token
  pm_tls_insecure     = true #to not verify checking for certificates

}
