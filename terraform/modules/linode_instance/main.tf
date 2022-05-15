

resource "linode_instance" "instance" {
  label           = var.label
  image           = var.image
  region          = var.region
  type            = var.type
  group           = var.group
  authorized_keys = var.sshkeys
  root_pass       = var.root_pass

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_pass
    host     = self.ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sed 's/#Port 22/Port 7109/g' /etc/ssh/sshd_config",
      "systemctl restart sshd"
    ]
  }

}

# resource "linode_firewall_device" "my_device" {
#   firewall_id = linode_firewall.default_web.id
#   entity_id = linode_instance.instance.id
# }



