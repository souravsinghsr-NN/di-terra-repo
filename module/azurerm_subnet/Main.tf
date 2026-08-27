resource "azurerm_subnet" "Subnets" {
    for_each = var.Subnets
  name                 = each.value.subnet_name
  resource_group_name  = each.value.rg_name
  virtual_network_name = each.value.Vnet_name
  address_prefixes     = each.value.address_prefixes
}