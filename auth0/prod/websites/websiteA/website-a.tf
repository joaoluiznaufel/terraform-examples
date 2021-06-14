resource "auth0_tenant" "website-a-tenant" {
  friendly_name = "Website-a.com"
}

resource "auth0_custom_domain" "website-a_custom_domain" {
  domain = "auth.website-a.com"
  type = "auth0_managed_certs"
  verification_method = "txt"
}