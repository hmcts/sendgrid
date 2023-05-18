variable "environment" {
  description = "SendGrid Configuration"
}

variable "account" {
  description = "SendGrid subuser account"
}

variable "domains" {
  description = "Domains being authenticated"
}

variable "email" {
  description = "Sendgrid account email"
  default = "DTSPlatformOps@HMCTS.NET"
}