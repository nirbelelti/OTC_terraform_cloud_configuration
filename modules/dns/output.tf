output "name" {
  value = opentelekomcloud_dns_zone_v2.dns_zone.id
}

output "dns_recordset" {
  value = jsonencode(opentelekomcloud_dns_recordset_v2.dns_recordset)
}