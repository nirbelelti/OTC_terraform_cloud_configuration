resource "opentelekomcloud_dns_zone_v2" "dns_zone" {
  name        = "${var.name}-${var.stage_name}-${var.domain_name}."
  email       = var.email
  description = var.record_description
  ttl         = var.ttl
  type        = var.dns_type

  tags = var.tags
}

resource "opentelekomcloud_dns_recordset_v2" "dns_recordset" {
  for_each = var.a_records

  zone_id     = opentelekomcloud_dns_zone_v2.dns_zone.id
  name        = each.key == var.domain_name ? var.domain_name :
    join(".", [trimsuffix(each.key, ".${var.domain_name}"), var.domain_name])
  description = var.record_description
  ttl         = var.ttl
  type        = var.rs_type
  records     = each.value
}
