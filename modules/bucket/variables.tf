variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "stage_name" {
  description = "Deployment stage (e.g., dev, prod)"
  type        = string
}

variable "access_control_list" {
  description = "ACL for the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
}

variable "allowed_ip" {
  description = "IP address allowed in the bucket policy"
  type        = string
  default     = "8.8.8.8/32" # default IP, can be overridden
}




