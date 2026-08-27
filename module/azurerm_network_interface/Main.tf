data "azurerm_subnet" "subnet" {
  for_each             = var.nics
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
  }

  tags = lookup(each.value, "tags", {
    environment = "Production"
  })
}

data "azurerm_network_security_group" "nsg" {
  for_each            = { for k, v in var.nics : k => v if lookup(v, "nsg_name", null) != null }
  name                = each.value.nsg_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  for_each                  = { for k, v in var.nics : k => v if lookup(v, "nsg_name", null) != null }
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg[each.key].id
}
