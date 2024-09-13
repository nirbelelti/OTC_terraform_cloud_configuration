terraform {
  required_version = ">= 1.0.0"

  required_providers {
    opentelekomcloud = {
      source  = "Opentelekomcloud/opentelekomcloud"
      version = ">= 1.36.0"
    }
  }
}
