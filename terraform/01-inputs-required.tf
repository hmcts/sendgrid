variable "env" {
  description = "SendGrid Configuration"
  type        = string
}

variable "subusers" {
  description = "SendGrid subuser accounts"
  type = list(object({
    username = string
    email    = string
    ips      = list(string)
    })
  )
}