
resource "opentelekomcloud_lb_loadbalancer_v2" "lb_1" {
    name = "ELB_${var.name}-${var.stage_name}"
  vip_subnet_id = var.subnet_id

  tags = {
    muh = "kuh"
  }
}


resource "opentelekomcloud_vpc_eip_v1" "ingress_eip" {
  bandwidth {
    charge_mode = "traffic"
    name        = "${var.name}-${var.stage_name}-${var.context_name}-ingress-bandwidth"
    share_type  = "PER"
    size        = var.bandwidth
  }
  publicip {
    type    = "5_bgp"
  }
}