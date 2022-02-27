
resource "gandi_livedns_record" "main_record" {
    zone    = var.zone
    name    = var.record_name
    values  = [ var.address ]
    type    = var.address_type
    ttl     = var.ttl
}

resource "gandi_livedns_record" "additional_records" {
    zone    = var.zone
    for_each = toset(var.additional_names)
    name     = each.key
    values  = [ var.record_name ]
    type    = "CNAME"
    ttl     = var.ttl
}



