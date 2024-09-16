variable "domain_name" {
  type        = string
  description = "The domain name for the DNS zone or service identifies resources or services within a network. Changing this value creates a new DNS zone."
}

variable "zone_description" {
  type        = string
  default     = "The DNS zone for the domain name."
  description = "(Optional variable) Brief description of the DNS zone. Provides context about its purpose or content."
}

variable "record_description" {
  type        = string
  default     = ""
  description = "(Optional) Brief description of the DNS record set (PTR Record). Provides context about its purpose or content."
}

variable "ttl" {
  type        = number
  default     = 300
  description = "(Optional) The time-to-live (TTL) value for the DNS zone. The TTL specifies how long the record is cached in resolvers. Changing this value creates a new DNS zone. (Default: 300)"
}

variable "email" {
  type        = string
  default     = "dl-otc-domains@telekom.de"
  description = "(Optional) The email address of the DNS zone administrator. Changing this value creates a new DNS zone."
}

variable "dns_type" {
  type        = string
  default     = "public"
  description = "The DNS zone type. Valid values are 'public' (for public DNS zones) and 'private' (for private DNS zones). Changing this value creates a new DNS zone."
}

variable "tags" {
  type = map(any)
  default     = null
  description = "(Optional) A map of tags to assign to the DNS zone and record set. Tags are key-value pairs that provide additional context and metadata about the resource."
}

variable "rs_type" {
  type        = string
  default     = "A"
  description = "The DNS record type. Valid values are 'A', 'AAAA', 'CNAME', 'MX', 'NS', 'PTR', 'SOA', 'SRV', and 'TXT'. Changing this value creates a new DNS record set."
}

variable "a_records" {
  type = map(any)
  default = {}
  description = "(Optional) A map of DNS A records to create in the DNS zone. The map key is the record name, and the map value is a list of record values. Changing this value creates new DNS record sets."
}

variable "name" {
  type        = string
  description = "The name of the project."
}
variable "stage_name" {
  type        = string
  description = "The environment for the project."
}
