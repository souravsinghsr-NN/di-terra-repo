data "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.rg_name
  location                        = each.value.location
  size                            = lookup(each.value, "size", "Standard_B1s")
  admin_username                  = lookup(each.value, "admin_username", "azureuser")
  admin_password                  = lookup(each.value, "admin_password", "P@ssw0rd1234!")
  disable_password_authentication = lookup(each.value, "disable_password_authentication", false)
  network_interface_ids           = [data.azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = lookup(each.value, "os_disk_caching", "ReadWrite")
    storage_account_type = lookup(each.value, "os_disk_type", "Standard_LRS")
    disk_size_gb         = lookup(each.value, "os_disk_size_gb", 30)
  }

  source_image_reference {
    publisher = lookup(each.value, "image_publisher", "Canonical")
    offer     = lookup(each.value, "image_offer", "0001-com-ubuntu-server-jammy")
    sku       = lookup(each.value, "image_sku", "22_04-lts")
    version   = lookup(each.value, "image_version", "latest")
  }

  tags = lookup(each.value, "tags", {
    environment = "Production"
  })
}
