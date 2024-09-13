resource "opentelekomcloud_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}-${var.stage_name}"
  acl    = var.access_control_list
  tags   = var.tags
}

resource "opentelekomcloud_s3_bucket_policy" "bucket_policy" {
  bucket = opentelekomcloud_s3_bucket.bucket.id
  policy = <<POLICY
  {
    "Id": "MYBUCKETPOLICY",
    "Statement": [
      {
        "Sid": "IPAllow",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": "arn:aws:s3:::${opentelekomcloud_s3_bucket.bucket.bucket}/*",
        "Condition": {
          "IpAddress": {"aws:SourceIp": "${var.allowed_ip}"}
        }
      }
    ]
  }
  POLICY
}
