resource "azurerm_network_acl" "example" {
  name                = "webapp-acl"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  default_action = "Deny"

  # Allow All
  bypass = "AzureServices"
  default_action = "Deny"

  subnet {
    id = azurerm_subnet.example.id
  }

  ip_rule {
    name                     = "DenyIran"
    action                   = "Deny"
    priority                 = 100
    source_address_prefix    = "1.0.0.0/8"
    destination_address_prefix = "*"
    source_port_range        = "*"
    destination_port_range   = "*"
    protocol                 = "*"
  }
}
