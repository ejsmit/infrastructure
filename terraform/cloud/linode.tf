

# Default Web Firewall

resource "linode_firewall" "default_web" {
  label = "default_web"
  tags  = ["terraform"]

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-custom-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "7109"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-wireguard"
    action   = "ACCEPT"
    protocol = "UDP"
    ports    = "51999"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

}
