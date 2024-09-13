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

