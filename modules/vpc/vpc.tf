resource "opentelekomcloud_vpc_v1" "vpc" {
  name   = "vpc-${var.name}-${var.stage_name}"
  cidr   = var.cidr_block
  tags   = var.tags
}

resource "opentelekomcloud_vpc_subnet_v1" "subnets" {
  for_each   = var.subnets
  name       = each.key
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = replace(each.value, "default-cidr", opentelekomcloud_vpc_v1.vpc.cidr)
  gateway_ip = cidrhost(replace(each.value, "default-cidr", opentelekomcloud_vpc_v1.vpc.cidr), 1)
  dns_list   = var.dns_config
  tags       = var.tags
}