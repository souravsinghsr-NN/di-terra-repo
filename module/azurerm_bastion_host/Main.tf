data "azurerm_subnet" "bastion_subnet" {
  for_each             = var.bastions
  name                 = "AzureBastionSubnet"
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "bastion_pip" {
  for_each            = var.bastions
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastions
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  sku                 = lookup(each.value, "sku", "Basic")

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion_subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.bastion_pip[each.key].id
  }

  tags = lookup(each.value, "tags", {
    environment = "Production"
  })
}
