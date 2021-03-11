variable "environment" {
  description = "SendGrid Configuration"
  type        = string
}

variable "accounts" {
  description = "SendGrid subuser accounts"
  type   = list(object({
    name = string
    ips  = list(string)
    })
  )
}