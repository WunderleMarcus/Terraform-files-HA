# deklaration der ressourcen gruppe und location
locals {
 Ressource_Group_Name = "marcus-wunderle-rg1"
 Ressource_Group_Location = "West Europe"
}


## resourcen gruppe erstellen
resource "azurerm_resource_group" "marcus-wunderle-rg1" {
  name     = local.Ressource_Group_Name
  location = local.Ressource_Group_Location
}


## erstellen des storage accounts
resource "azurerm_storage_account" "demo_account_marcus" {
  name                     = "demostoragemarcus"
  resource_group_name      = local.Ressource_Group_Name
  location                 = local.Ressource_Group_Location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  depends_on = [
    azurerm_resource_group.marcus-wunderle-rg1
  ]
}

# erstellen des blob containers
resource "azurerm_storage_container" "tsblobcontainer" {
  name                  = "tsblobcontainer"
  storage_account_name  = "demostoragemarcus"
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.demo_account_marcus
  ]
}