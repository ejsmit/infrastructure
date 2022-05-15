
# Global variables


# Variables per managed host

variable "arwen_linode_instance" {
    type = string
}
variable "arwen_name" {
    type = string
}
variable "arwen_additional_names" {
  type = set(string)
}


variable "galadriel_linode_instance" {
    type = string
}
variable "galadriel_name" {
    type = string
}
variable "galadriel_additional_names" {
  type = set(string)
}




# various data values looked up from providers for reuse.

data "linode_sshkey" "rsmit" {
  label = "rsmit-radagast"
}

data "gandi_domain" "personal_domain" {
  name = yamldecode(file("~/.private/ansible/vars/me-myself-and-i.yml"))["private_my_dns_domain"]
}


# Some lookup values for providers

locals {
  # Address types 
  gandi_type_ipv4 = "A"
  gandi_type_ipv6 = "AAAA"
  # TTL values in seconds
  gandi_ttl_3hours = "10800"
}

locals {
  # Linode Regions 
  linode_region_us_east = "us-east"
  linode_region_uk = "eu-west"
  # Linode Instance Types
  linode_type_5usd_1gb = "g6-nanode-1"         #1vcpu, 1gb, 25gb
  linode_type_10usd_2gb = "g6-standard-1"      #1vcpu, 2gb, 50gb 
  # Linode Images
  linode_image_ubuntu2004 = "linode/ubuntu20.04"
  linode_image_ubuntu2110 = "linode/ubuntu21.10"
  linode_image_ubuntu2204 = "linode/ubuntu22.04"
}



