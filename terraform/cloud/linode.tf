

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


# ICMP (optional: as of 0.14.0 this should not be necessary, but previous versions require nodes to ping the server over public IP
# 51821-518XX (udp): for WireGuard - Netmaker needs one port per network, starting with 51821, so open up a range depending on the number of networks you plan on having. For instance, 51821-51830.
# 53 (udp and tcp): for CoreDNS - This is no longer necessary as of 0.10.0, but in some cases you may still want to use CoreDNS externally.
# 8883 (tcp): for MQ Broker

resource "linode_firewall" "netmaker_server" {
  label = "netmaker_server"
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
    ports    = "51821-51825"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-messagebroker"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "8883"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  # inbound {
  #   label    = "allow-dns-tcp"
  #   action   = "ACCEPT"
  #   protocol = "TCP"
  #   ports    = "53"
  #   ipv4     = ["0.0.0.0/0"]
  #   ipv6     = ["::/0"]
  # }

  # inbound {
  #   label    = "allow-dns-udp"
  #   action   = "ACCEPT"
  #   protocol = "UDP"
  #   ports    = "53"
  #   ipv4     = ["0.0.0.0/0"]
  #   ipv6     = ["::/0"]
  # }

}






