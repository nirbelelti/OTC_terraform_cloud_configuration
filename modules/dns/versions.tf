terraform {
  required_version = ">= 1.3.0"

  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = ">=1.36.0"
    }
  }  
}
