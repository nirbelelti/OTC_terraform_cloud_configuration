# Add-ons: Autoscaler
resource "opentelekomcloud_cce_addon_v3" "autoscaler" {
  cluster_id       = opentelekomcloud_cce_cluster_v3.cluster.id
  template_name    = "autoscaler"
  template_version = var.autoscaler_version

  values {
    basic = {
      "region"    = var.region
    }
    custom = {
      "maxNodesTotal" = var.autoscaling_max_nodes
      "minNodesTotal" = var.autoscaling_min_nodes
    }
  }
}

# Add-ons: Metrics Server
resource "opentelekomcloud_cce_addon_v3" "metrics" {
  cluster_id       = opentelekomcloud_cce_cluster_v3.cluster.id
  template_name    = "metrics-server"
  template_version = var.metrics_version
  values {
    basic = {
      "swr_addr" = var.otc_addon_image_endpoint
      "swr_user" = "hwofficial"
    }
    custom = {}
  }
}
# Kubectl Configuration
resource "local_file" "kubeconfig" {
  content  = opentelekomcloud_cce_cluster_v3.cluster.id
  filename = "${path.module}/kubeconfig_${var.name}_${var.stage_name}.yaml"
}