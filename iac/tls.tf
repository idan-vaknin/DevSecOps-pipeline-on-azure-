resource "azurerm_app_service_certificate" "example" {
  name                = "example-tls-cert"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  pfx_blob            = filebase64("./certs/tls-certificate.pfx")
  password            = var.tls_certificate_password
}

resource "azurerm_app_service_certificate_binding" "example" {
  name                = "example-tls-binding"
  resource_group_name = azurerm_resource_group.rg.name
  hostname            = azurerm_app_service.web.default_site_hostname
  certificate_thumbprint = azurerm_app_service_certificate.example.thumbprint
  ssl_state           = "SniEnabled"
}
