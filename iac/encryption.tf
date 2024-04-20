resource "azurerm_sql_transparent_data_encryption" "example" {
  name                = "example-tde"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.example.name
  database_name       = azurerm_sql_database.example.name
  
  enabled = true
}
