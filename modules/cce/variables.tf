# variable "name" {
#   type        = string
#   description = "CCE cluster name"
# }
#
# variable "tags" {
#   type        = map(any)
#   description = "Common tag set for CCE resources"
#   default     = null
# }
#
# variable "cluster_config" {
#   description = "Cluster configuration parameters"
#   type = object({
#     vpc_id                 = string           // VPC id where the cluster will be created in
#     subnet_id              = string           // Subnet network id where the cluster will be created in
#     cluster_version        = optional(string, "1.23")          // CCE cluster version.
#     cluster_size           = optional(string, "small") // Size of the cluster: small, medium, large (default: small)
#     cluster_type           = optional(string,"VirtualMachine") // Cluster type: VirtualMachine or BareMetal (default: VirtualMachine)
#     container_network_type = optional(string,"vpc-router")// Container network type: vpc-router or overlay_l2 for VirtualMachine Clusters; underlay_ipvlan for BareMetal Clusters
#     container_cidr         = optional(string, "172.16.0.0/16") // Kubernetes pod network CIDR range (default: 172.16.0.0/16)
#     service_cidr           = optional(string, "10.247.0.0/16") // Kubernetes service network CIDR range (default: 10.247.0.0/16)
#     high_availability      = optional(bool)   // Create the cluster in highly available mode (default: false)
#     enable_scaling         = optional(bool)   // Enable autoscaling of the cluster (default: false)
#   })
#   validation {
#     condition     = contains(["small", "medium", "large"], lower(var.cluster_config.cluster_size == null ? "small" : var.cluster_config.cluster_size))
#     error_message = "Allowed values for cluster_size are \"small\", \"medium\" and \"large\"."
#   }
#   validation {
#     condition     = contains(["VirtualMachine", "BareMetal"], var.cluster_config.cluster_type == null ? "VirtualMachine" : var.cluster_config.cluster_type)
#     error_message = "Allowed values for cluster_type are \"VirtualMachine\" and \"BareMetal\"."
#   }
#   validation {
#     condition = (
#       var.cluster_config.container_network_type == null ||
#       (try(contains(["vpc-router", "overlay_l2"], var.cluster_config.container_network_type), false) && (var.cluster_config.cluster_type == "VirtualMachine" || var.cluster_config.cluster_type == null)) ||
#       (try(contains(["underlay_ipvlan"], var.cluster_config.container_network_type), false) && var.cluster_config.cluster_type == "BareMetal")
#     )
#     error_message = "Allowed values for container_network_type are \"vpc-router\" and \"overlay_l2\" for VirtualMachine Clusters; and \"underlay_ipvlan\" for BareMetal Clusters."
#   }
# }
#
# locals {
#
#   container_network_type = var.cluster_config.cluster_type == "VirtualMachine" || var.cluster_config.cluster_type == null ? "vpc-router" : "underlay_ipvlan"
# }
#
# variable "node_config" {
#   description = "Cluster node configuration parameters"
#   type = object({
#     availability_zones = optional(list(string),["eu-de-01", "eu-de-02", "eu-de-03"] ) // Availability zones for the node pool (default: ["eu-de-03"])
#     node_count         = optional(number,1)              // Number of nodes to create
#     node_flavor        = optional(string)       // Node specifications in otc flavor format
#     node_os            = optional(string,"EulerOS 2.5")       // Operating system of worker nodes: EulerOS 2.5 or CentOS 7.7 (default: EulerOS 2.5)
#     node_storage_type  = optional(string, "SATA")       // Type of node storage SATA, SAS or SSD (default: SATA)
#     node_storage_size  = optional(number,100)       // Size of the node system disk in GB (default: 100)
#     node_postinstall   = optional(string,"")       // Post install script for the cluster ECS node pool.
#   })
# }
#
# ###### Addons variables #########
# variable "autoscaling_config" {
#   description = "Autoscaling configuration parameters"
#   type = object({
#     nodes_max       = optional(number, 10) // Maximum limit of servers to create (default: 10)
#     nodes_min       = optional(number, 3 ) // Lower bound of servers to always keep (default: <node_count>)
#     cpu_upper_bound = optional(number, 0.8) // Cpu utilization upper bound for upscaling (default: 0.8)
#     mem_upper_bound = optional(number, 0.8) // Memory utilization upper bound for upscaling (default: 0.8)
#     lower_bound     = optional(number, 0.2) // Memory AND cpu utilization lower bound for downscaling (default: 0.2)
#     version         = optional(string, "1.23.6") // Version of the Autoscaler Addon Template (default: 1.23.6)
#   })
# }
#
#
# variable "region" {
#   type = string
# }
#
# variable "bandwidth_size" {
#   type = number
#   default = 50
#   description = "The bandwidth of our cce set to default of 50 but can be overidden"
# }
#
# variable "stage_name" {
#   type = string
#   description = "The stage name"
# }
#
# data "opentelekomcloud_identity_project_v3" "current" {
# }
# locals {
#   otc_addon_image_endpoint = data.opentelekomcloud_identity_project_v3.current.region == "eu-de" ? "100.125.7.25:20202" : "swr.eu-nl.otc.t-systems.com"
# }
#
# locals {
#   autoscaler_version = "1.23.6"
# }
#
# locals {
#   matrix_version = "1.2.1"
# }
#
# variable "flavor_id" {
#   type = string
# }

variable "name" {
  description = "The name of the project."
  type        = string
}

variable "stage_name" {
  description = "The stage name for the cluster (e.g., dev, prod)."
  type        = string
}

variable "region" {
  description = "The region for the cluster."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID for the cluster."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the cluster."
  type        = string
}

variable "flavor_id" {
  description = "The flavor ID for the CCE cluster nodes."
  type        = string
}

variable "service_cidr" {
  description = "The CIDR range for Kubernetes services."
  type        = string
  default     = "10.247.0.0/16"
}

variable "node_flavor" {
  description = "The node flavor for the node pool."
  type        = string
  default = "cce.s1.small"
}

variable "node_count" {
  description = "The number of nodes in the node pool."
  type        = number
  default     = 3
}

variable "availability_zones" {
  description = "The availability zones to distribute the nodes."
  type        = list(string)
  default     = []
}

variable "key_pair" {
  description = "The key pair name for the node pool."
  type        = string
}

variable "node_os" {
  description = "The OS for the node pool (e.g., EulerOS, Ubuntu)."
  type        = string
}

variable "node_storage_type" {
  description = "The type of storage for the nodes (e.g., SSD)."
  type        = string
}

variable "node_storage_size" {
  description = "The size of the storage for the nodes."
  type        = number
  default     = 100
}

variable "autoscaler_version" {
  description = "The version of the autoscaler addon."
  type        = string
  default     = "1.15.2"
}

variable "metrics_version" {
  description = "The version of the metrics-server addon."
  type        = string
  default     = "1.2.1"
}

variable "autoscaling_max_nodes" {
  description = "The maximum number of nodes for autoscaling."
  type        = number
  default     = 10
}

variable "autoscaling_min_nodes" {
  description = "The minimum number of nodes for autoscaling."
  type        = number
  default     = 1
}

variable  "otc_addon_image_endpoint" {
  description=  "The endpoint for the OTC addon image."
  type= string
  default=  "100.125.7.25:20202"
}

variable "bandwidth_size" {
  type = number
  default = 50
  description = "The bandwidth of our cce set to default of 50 but can be overidden"
}

variable "tags" {
  type        = map(any)
  description = "Common tag set for CCE resources"
  default     = null
}

variable "cluster_type" {
    description = "The type of the CCE cluster."
    type        = string
    default     = "VirtualMachine"
}

variable "kubeconfig_expiry_date" {
    description = "The expiry date for the kubeconfig file."
    type        = string
}