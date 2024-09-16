variable "name" {
  type        = string
  description = "The name of the project."
}

variable "stage_name" {
  type        = string
  description = "The stage name for the cluster (e.g., dev, prod)."
}

variable "description" {
  default     = "a software repository for container images."
  type        = string
  description = "This is a software repository for container images."
}

variable "is_public" {
  default     = false
  type        = bool
  description = "Whether the repository is public or private."
}