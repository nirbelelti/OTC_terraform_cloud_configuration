variable "create_bucket" {
  type        = bool
  default     = false
  description = "Whether to create a bucket for the configuration secrets."
}
variable "name" {
  type        = string
  description = "The name of the project."
}
variable "stage_name" {
  type        = string
  description = "The stage name for the cluster (e.g., dev, prod)."
}
variable "bucket_object_key" {
  type        = string
  description = "The key for the bucket object."
}

variable "configuration_secrets" {
  type = map(any)
  description = "The configuration secrets to store in the bucket."
}