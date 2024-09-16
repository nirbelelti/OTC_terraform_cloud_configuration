# Generate a TLS private key
resource "tls_private_key" "cluster_keypair" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

# Create a compute key pair using the generated TLS private key
resource "opentelekomcloud_compute_keypair_v2" "cluster_keypair" {
  name       = "${var.name}-cluster-keypair-${var.stage_name}"
  public_key = tls_private_key.cluster_keypair.public_key_openssh
}

# Create an Elastic IP (EIP) with specific bandwidth settings
resource "opentelekomcloud_vpc_eip_v1" "cce_eip" {
  bandwidth {
    charge_mode = "traffic"
    name        = "${var.name}-cluster-kubectl-endpoint"
    share_type  = "PER"
    size        = var.bandwidth_size
  }
  tags = var.tags

  publicip {
    type = "5_bgp"
  }
}

# Create a shared subnet for the CCE cluster
data "opentelekomcloud_vpc_subnet_v1" "shared_subnet" {
  name = " ${var.name}-${var.stage_name}-shared-subnet"
}

resource "opentelekomcloud_cce_cluster_v3" "cluster" {
  name                    = "turo-cce-${var.name}-${var.stage_name}"
  cluster_type            = var.cluster_type
  flavor_id               = var.flavor_id
  vpc_id                  = data.opentelekomcloud_vpc_subnet_v1.shared_subnet.vpc_id
  subnet_id               = data.opentelekomcloud_vpc_subnet_v1.shared_subnet.network_id
  container_network_type  = "eni"
  kubernetes_svc_ip_range = var.service_cidr
  description             = "Kubernetes Turbo Cluster ${var.name}."
  authentication_mode     = "x509"
  eni_subnet_id           = data.opentelekomcloud_vpc_subnet_v1.shared_subnet.subnet_id
  eni_subnet_cidr         = data.opentelekomcloud_vpc_subnet_v1.shared_subnet.cidr

  timeouts {
    create = "60m"
    delete = "60m"
  }
}

# Create a node pool within the CCE cluster
resource "opentelekomcloud_cce_node_pool_v3" "node_pool" {
  cluster_id         = opentelekomcloud_cce_cluster_v3.cluster.id
  name               = "${var.name}-node-pool"
  flavor             = var.node_flavor
  initial_node_count = var.node_count
  availability_zone  = var.availability_zones[0]
  key_pair           = opentelekomcloud_compute_keypair_v2.cluster_keypair.name
  os                 = var.node_os

  root_volume {
    size       = 50
    volumetype = "SSD"
  }

  data_volumes {
    size       = var.node_storage_size
    volumetype = var.node_storage_type
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }
}

# Generate a Kubernetes configuration file for the CCE cluster
data "opentelekomcloud_cce_cluster_kubeconfig_v3" "this" {
  cluster_id  = opentelekomcloud_cce_cluster_v3.cluster.id
  expiry_date = var.kubeconfig_expiry_date
}