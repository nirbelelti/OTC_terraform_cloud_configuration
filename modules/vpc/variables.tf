variable "name" {
  type        = string
  description = "The name of the VPC resource."
}

variable "tags" {
  type        = map(string)
  description = "Key-value pairs to tag the VPC and associated resources."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block defining the IP address range for the VPC."
}

variable "subnets" {
  type        = map(string)
  description = "A map of subnet names to their respective CIDR ranges."
  default = {
    default-subnet = "default_cidr"
  }
}

variable "dns_config" {
  type        = list(string)
  description = "List of DNS server IP addresses to be applied across all subnets."
  default = [
    "100.125.4.25",
    "100.125.129.199",
  ]
}

variable "stage_name" {
  type        = string
  description = "The deployment stage (e.g., dev, prod)."
}
