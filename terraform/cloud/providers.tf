
terraform {

  backend "http" {
    address = "https://objectstorage.uk-cardiff-1.oraclecloud.com/p/l93O8UldM_T5XyBeEfxeyVKqPW94h_tKuEmoBcG6RxPQQs0VbdOwtSzq0NcQukJ5/n/axyjefw5xs4w/b/terraform/o/terraform.tfstate"
    update_method = "PUT"
  }

  required_providers {
    linode = {
      source = "linode/linode"
      version = ">1.16.0"
    }
    gandi = {
      source = "go-gandi/gandi"
      version = "~> 2.0.0"    }
  }
}

provider "linode" {
    token = yamldecode(file("~/.private/ansible/vars/me-myself-and-i.yml"))["private_linode_token"]
}

provider "gandi" {
    key = yamldecode(file("~/.private/ansible/vars/me-myself-and-i.yml"))["private_gandi_api_token"]
}



