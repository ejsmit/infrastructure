
variable "zone" {
  type = string
}

variable "record_name" {
  type = string
}

variable "address" {
  type = string
}

variable "address_type" {
  description = "Either A or AAAA, depending on ipv4 or ipv6 address supplied"
  type = string
}

variable "additional_names" {
  type = list(string)
}

variable "ttl" {
  type = string
}

