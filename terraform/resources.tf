resource "digitalocean_ssh_key" "k8s" {
  name       = "k8s fingerprint"
  public_key = file("c://terraform/digitalocean/.ssh/id_rsa.pub")
}

resource "digitalocean_tag" "k8s-node" {
  name = "k8s-node"
}


resource "digitalocean_droplet" "gw" {
  name     = "gw"
  tags   = [digitalocean_tag.k8s-mng.id]
  size     = "s-1vcpu-2gb"
  image    = "ubuntu-18-04-x64"
  region   = var.region
  ipv6     = false
  private_networking = var.private_networking
  vpc_uuid = digitalocean_vpc.k8s-network.id
  ssh_keys = [digitalocean_ssh_key.k8s.fingerprint]
}

resource "digitalocean_droplet" "node01" {
  name     = "node01"
  tags   = [digitalocean_tag.k8s-node.id]
  size     = "s-2vcpu-4gb"
  image    = "ubuntu-18-04-x64"
  region   = var.region
  ipv6     = false
  private_networking = var.private_networking
  vpc_uuid = digitalocean_vpc.k8s-network.id
  ssh_keys = [digitalocean_ssh_key.k8s.fingerprint]
}

resource "digitalocean_droplet" "node02" {
  name     = "node02"
  tags   = [digitalocean_tag.k8s-node.id]
  size     = "s-2vcpu-4gb"
  image    = "ubuntu-18-04-x64"
  region   = var.region
  ipv6     = false
  private_networking = var.private_networking
  vpc_uuid = digitalocean_vpc.k8s-network.id
  ssh_keys = [digitalocean_ssh_key.k8s.fingerprint]
}



