resource "digitalocean_tag" "k8s-mng" {
  name = "k8s-mng"
}

resource "digitalocean_vpc" "k8s-network" {
  name     = "k8s-network"
  region   =  var.region
  ip_range = "10.1.2.0/24"
}

resource "digitalocean_firewall" "k8s" {
  name  = "k8s-firewall-mng"
  tags   = [digitalocean_tag.k8s-mng.id]
  droplet_ids = [digitalocean_droplet.gw.id]
  count = "1"
  inbound_rule {
      protocol                = "tcp"
      port_range              = "25575"
      source_addresses        = ["0.0.0.0/0", "::/0"]
    }
  inbound_rule {
      protocol                = "tcp"
      port_range              = "25565"
      source_addresses        = ["0.0.0.0/0", "::/0"]
    }
  inbound_rule {
      protocol                = "tcp"
      port_range              = "22"
      source_addresses        = ["0.0.0.0/0", "::/0"]
    }
  inbound_rule {
      protocol                = "tcp"
      port_range              = "80"
      source_addresses        = ["0.0.0.0/0", "::/0"]
    }
  inbound_rule {
      protocol                = "tcp"
      port_range              = "443"
      source_addresses        = ["0.0.0.0/0", "::/0"]
    }
  inbound_rule {
      protocol                = "tcp"
      port_range              = "554"
      source_addresses        = ["0.0.0.0/0", "::/0"]
    }
  outbound_rule {
      protocol                = "tcp"
      port_range              = "all"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }
  outbound_rule {
      protocol                = "udp"
      port_range              = "all"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }
  outbound_rule {
      protocol                = "icmp"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }    
}



resource "digitalocean_firewall" "k8s-node" {
  name  = "k8s-firewall-node"
  tags   = [digitalocean_tag.k8s-node.id]

  inbound_rule {
      protocol                = "tcp"
      port_range              = "80"
      source_addresses        = ["0.0.0.0/0", "::/0"]
    }

  inbound_rule {
      protocol                = "tcp"
      port_range              = "22-10000"
      source_addresses        = ["10.1.2.0/24"]
    }
  inbound_rule {
      protocol                = "udp"
      port_range              = "22-10000"
      source_addresses        = ["10.1.2.0/24"]
    }

  inbound_rule {
      protocol                = "icmp"
      source_addresses        = ["10.1.2.0/24"]
    }


  outbound_rule {
      protocol                = "tcp"
      port_range              = "all"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }
  outbound_rule {
      protocol                = "udp"
      port_range              = "all"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }
  outbound_rule {
      protocol                = "icmp"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }    
}


/* 
data "digitalocean_vpc" "k8s-network" {
  name = "k8s-network"
}


output "vpc_output" {
  value = data.digitalocean_vpc.k8s-network.ip_range
}
*/