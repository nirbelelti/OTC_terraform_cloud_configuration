variable "stage_name" {
  type        = string
  description = "The stage name for the cluster (e.g., dev, prod)."
}
variable "name" {
  type        = string
  description = "The name of the project."
}
variable "subnet_id" {
  type        = string
  description = "The subnet ID for the cluster."
}
variable "context_name" {
  default = "ingress"
  type        = string
  description = "The name of the context."
}
variable "bandwidth" {
  type        = number
  default     = 300
  description = "The bandwidth for the EIP."
}