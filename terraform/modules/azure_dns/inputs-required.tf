
variable "dns_resource_group" {
  type        = string
  description = "The name of the resource group that contains the DNS zone where the records will be added."
  default     = "reformmgmtrg"
}

variable "zone_name" {
  type        = string
  description = "The zone name for the CNAME Record"
}

variable "dns_records" {
  description = "This are the DNS record exported from the sendgrid"
}

variable "subscription_id" {
  type        = string
  description = "The subscription ID where the dns zone is located"
  default     = "ed302caf-ec27-4c64-a05e-85731c3ce90e"
}