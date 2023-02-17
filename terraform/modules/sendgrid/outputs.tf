output "dns_records" {
  #   value = sendgrid_domain_authentication.domain-authenticate.dns[*]

  value = {
    for n, record in toset(var.domains) :
    "${n}" => {
      record1 = {
        host = sendgrid_domain_authentication.domain-authenticate["${n}"].dns[0].host
        data = sendgrid_domain_authentication.domain-authenticate["${n}"].dns[0].data
      }
      record2 = {
        host = sendgrid_domain_authentication.domain-authenticate["${n}"].dns[1].host
        data = sendgrid_domain_authentication.domain-authenticate["${n}"].dns[1].data
      }
      record3 = {
        host = sendgrid_domain_authentication.domain-authenticate["${n}"].dns[2].host
        data = sendgrid_domain_authentication.domain-authenticate["${n}"].dns[2].data
      }
    }
  }
}