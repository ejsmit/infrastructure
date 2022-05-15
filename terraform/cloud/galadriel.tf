

module "galadriel_instance" {
    source = "../modules/linode_instance"

    label       = var.galadriel_linode_instance
    image       = local.linode_image_ubuntu2204
    region      = local.linode_region_uk
    type        = local.linode_type_5usd_1gb
    sshkeys     = [ data.linode_sshkey.rsmit.ssh_key ]
    root_pass   = yamldecode(file("~/.private/ansible/vars/me-myself-and-i.yml"))["private_default_linode_root_password"]

}

module "galadriel_dns" {
    source = "../modules/gandi_livedns"

    zone                = data.gandi_domain.personal_domain.id
    record_name         = var.galadriel_name
    address             = module.galadriel_instance.ipv4
    address_type        = local.gandi_type_ipv4
    additional_names    = var.galadriel_additional_names
    ttl                 = local.gandi_ttl_3hours
}


resource "linode_firewall_device" "galadriel" {
  firewall_id = linode_firewall.netmaker_server.id
  entity_id = module.galadriel_instance.id
}










