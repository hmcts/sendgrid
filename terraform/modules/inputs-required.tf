variable "environment" {
  description = "SendGrid Configuration"
}

variable "account" {
  description = "SendGrid subuser account"
}

variable "domains" {
  description = "Domains being authenticated"
}

variable "dns_resource_group" {
  type        = string
  description = "The name of the resource group that contains the DNS zone where the records will be added."
  default     = "reformmgmtrg"
}

variable "zone_name" {
  type        = string
  description = "The zone name for the CNAME Record"
  default     = "platform.hmcts.net"
}