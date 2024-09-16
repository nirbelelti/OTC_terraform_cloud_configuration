provider "opentelekomcloud" {
  user_name   = var.user_name
  password    = var.password
  domain_name = var.domain_name
  tenant_name = var.tenant_name
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
}

terraform {
  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = ">=1.35.0"
    }
  }
}

module "bucket" {
  source = "../../modules/bucket"

  bucket_name         = "var.bucket_name"
  stage_name          = var.stage_name
  access_control_list = var.access_control_list
  tags                = var.tags
  allowed_ip          = var.allowed_ip
}


variable "region" {
  default = ""
}
module "identity_project" {
  #Mandatory for creating a CCE in OTC
  source       = "../../modules/idetitiy_project"
  project_name = var.project_name
  description  = "Production environment for CST app"
}

module "vpc" {
  source     = "../../modules/vpc"
  name       = var.project_name
  stage_name = var.stage_name
  cidr_block = var.cidr
  tags       = var.tags
}

#Set ubuntu on the server image on the server
data "opentelekomcloud_images_image_v2" "ubuntu" {
  name       = "Standard_Ubuntu_20.04_latest"
  visibility = "public"
}

module "enable_cce_creation" {
  source = "../../modules/enable_cce_creation"
    project = var.project_name
    stage_name = var.stage_name
}



module "cce" {
  source      = "../../modules/cce"
  name                = var.project_name
  stage_name          =  var.stage_name
  region              = var.region
  vpc_id              = module.vpc.vpc.id
  subnet_id           = values(module.vpc.subnets)[0].subnet_id
  flavor_id           =  var.node_flavor
  service_cidr        = "192.168.0.0/16"
  node_flavor         = var.node_flavor
  node_count          = 3
  availability_zones  = ["eu-de-01", "eu-de-02", "eu-de-03"]
  node_os             = "EulerOS"
  node_storage_type   = "SSD"
  node_storage_size   = 100
  autoscaling_max_nodes = 8
  autoscaling_min_nodes = 1
  kubeconfig_expiry_date = "2024-12-31"
  depends_on = [module.vpc , module.enable_cce_creation]
}

module "dns" {
  source = "../../modules/dns"
    domain_name = "demo.com"
    name = var.project_name
    stage_name = var.stage_name
    tags = var.tags

  depends_on = [module.vpc]
}



