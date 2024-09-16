output "cluster_lb_public_ip" {
  value = opentelekomcloud_vpc_eip_v1.cce_eip.publicip[0].ip_address
}

output "node_pool_id" {
  value = opentelekomcloud_cce_node_pool_v3.node_pool.id
}

output "cluster_id" {
  value = opentelekomcloud_cce_cluster_v3.cluster.id
}

output "cluster_name" {
  value = opentelekomcloud_cce_cluster_v3.cluster.name
}

output "cluster_status" {
  value = opentelekomcloud_cce_cluster_v3.cluster.status
}

output "subnet_id" {
  value = data.opentelekomcloud_vpc_subnet_v1.shared_subnet.network_id
}

output "kubeconfig_file" {
  description = "Path to the generated Kubernetes configuration file."
  value       = local_file.kubeconfig.filename
}