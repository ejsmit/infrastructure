variable "label" {
  type = string
}

variable "image" {
  type = string
  default = null
}

variable "region" {
  type = string
}

variable "type" {
  type = string
}

variable "root_pass" {
  type = string
  sensitive = true
  default = null
}

variable "sshkeys" {
  type = list(string)
  default = null
}

variable "group" {
  type = string
  default = "terraform"
}
