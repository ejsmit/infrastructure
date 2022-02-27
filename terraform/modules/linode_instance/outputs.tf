output "ipv4" {
  value = tolist(linode_instance.instance.ipv4)[0]
}