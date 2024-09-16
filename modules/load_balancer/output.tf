output "elb_id" {
    value = opentelekomcloud_lb_loadbalancer_v2.lb_1.id
}

output "elb_public_ip" {
    value = opentelekomcloud_vpc_eip_v1.ingress_eip.publicip[0].ip_address
}