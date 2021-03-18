terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "do_token" {
# export TF_VAR_do_token 
}
variable "ssh_key_fingerprint" {
# export TF_VAR_ssh_key_fingerprint
}

variable private_networking {
  default = "true"
}

variable "region" {
  description = "home region"
  default = "fra1"
}


provider "digitalocean" {
  token = var.do_token
}


resource "digitalocean_project" "k8s-project" {
  name        = "k8s-project"
  description = "k8s cluster"
  purpose     = "Other"
  environment = "Production"
}
