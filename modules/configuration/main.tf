resource "opentelekomcloud_obs_bucket" "secrets" {
  count      = var.create_bucket ? 1 : 0
  bucket     = "${var.name}-${var.stage_name}-configuration"
  acl        = "private"
  versioning = true
    tags = {
        Name        = "${var.name}-${var.stage_name}-configuration"
        Environment = var.stage_name
    }
}


resource "opentelekomcloud_obs_bucket_object" "secrets" {
  key          = var.bucket_object_key
  encryption   = true
  content      = jsonencode(var.configuration_secrets)
  content_type = "application/json"
  bucket       =  opentelekomcloud_obs_bucket.secrets[0].bucket
}
