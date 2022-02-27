

# module "arwen_instance" {
#     source = "../modules/linode_instance"

#     label       = var.arwen_linode_instance
#     image       = local.linode_image_ubuntu2110
#     region      = local.linode_region_uk
#     type        = local.linode_type_5usd_1gb
#     sshkeys     = [ data.linode_sshkey.rsmit.ssh_key ]
#     root_pass   = yamldecode(file("~/.private/ansible/vars/me-myself-and-i.yml"))["private_default_linode_root_password"]

#     imported_config    = var.arwen_imported_config
# }

# module "arwen_dns" {
#     source = "../modules/gandi_livedns"

#     zone                = data.gandi_domain.personal_domain.id
#     record_name         = var.arwen_name
#     address             = module.arwen_instance.ipv4
#     address_type        = local.gandi_type_ipv4
#     additional_names    = var.arwen_additional_names
#     ttl                 = local.gandi_ttl_3hours
# }



# This is because the instance was manually created and imported into terraform.
# Remove everything below and uncomment top to start using terraform again.


resource  "linode_instance" "arwen_instance" {

    label       = var.arwen_linode_instance
    region      = local.linode_region_uk
    type        = local.linode_type_5usd_1gb

    config {
        kernel       = "linode/grub2"
        label        = "My Ubuntu 21.10 Disk Profile"
        root_device  = "/dev/sda"
        devices {
            sda {
                disk_label = "Ubuntu 21.10 Disk"
            }
            sdb {
                disk_label = "512 MB Swap Image"
            }
        }
    }
    disk {
        label            = "Ubuntu 21.10 Disk"
        size             = 25088
    }
    disk {
        label            = "512 MB Swap Image"
        size             = 512
    }
}

resource "linode_firewall_device" "arwen" {
  firewall_id = linode_firewall.default_web.id
  entity_id = linode_instance.arwen_instance.id
}


module "arwen_dns" {
    source = "../modules/gandi_livedns"

    zone                = data.gandi_domain.personal_domain.id
    record_name         = var.arwen_name
    address             = tolist(linode_instance.arwen_instance.ipv4)[0]
    address_type        = local.gandi_type_ipv4
    additional_names    = var.arwen_additional_names
    ttl                 = local.gandi_ttl_3hours
}







