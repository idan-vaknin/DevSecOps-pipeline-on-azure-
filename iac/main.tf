provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "webapp-rg"
  location = "East US"  # Change this to your desired region
}

resource "azurerm_app_service_plan" "asp" {
  name                = "webapp-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "web" {
  name                = "webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "DOCKER|nginx:latest"
    
    app_settings = {
      WEBSITES_PORT = "80"
    }

    https_only = true
  }
}

# Azure SQL Database
resource "azurerm_sql_server" "example" {
  name                         = "example-sql-server"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "exampleadmin"
  administrator_login_password = "ChangePassword1!"
  
  tags = {
    environment = "production"
  }
}

resource "azurerm_sql_database" "example" {
  name                = "example-db"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.example.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  sku_name            = "S0"
  
  tags = {
    environment = "production"
  }
}

# Enable TDE for SQL Database
resource "azurerm_sql_transparent_data_encryption" "example" {
  name                = "example-tde"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.example.name
  database_name       = azurerm_sql_database.example.name
  
  enabled = true
}
