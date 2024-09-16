variable "password" {
  default = "Your Passwoerd"
  type = string
  description = "Do not fill this variable here, it is ONLY for demo purposes, please use TF_VARS (https://developer.hashicorp.com/terraform/language/values/variables)"

}
variable "domain_name" {
  default = "Your Domain name"
  type = string
  description = "Do not fill this variable here, it is ONLY for demo purposes, please use TF_VARS (https://developer.hashicorp.com/terraform/language/values/variables)"

}
variable "tenant_name" {
  default = "You tatnent name"
  type = string
  description = "Do not fill this variable here, it is ONLY for demo purposes, please use TF_VARS (https://developer.hashicorp.com/terraform/language/values/variables)"
}

variable "bucket_name"{
  default = "My Bucket"
  type = string
  description = "Add the bucket name to the module"

}
variable "stage_name"{
  default= "dev"
  type = string
  description = "The stage name"

}

variable "access_control_list" {
  description = "ACL for the S3 bucket"
  type        = string
  default = "private"
}

variable "allowed_ip" {
  description = "IP address allowed in the bucket policy"
  type        = string
  default     = "203.0.113.0/24"
}

variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default = {
    Environment = "Dev"
    Project     = "DemoProject"
  }
}

variable "user_name" {
  description = "The user name for the OpenTelekomCloud provider"
  type        = string
}

variable "project_name" {
  default = "OTC-demo-project"
  type = string
  description = "The project's nane"
}

variable "cidr" {
  default = "192.168.0.0/16"
  type    = string
}

variable "node_flavor" {
  default = "s2.medium.1"
}

