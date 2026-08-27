resource "azurerm_public_ip" "pip" {
  for_each            = var.pip
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  allocation_method   = lookup(each.value, "allocation_method", "Static")
  sku                 = lookup(each.value, "sku", "Standard")

  tags = {
    environment = "Production"
  }
}