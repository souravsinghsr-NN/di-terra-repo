module "rgs" {
  source = "../../module/azurerm_resource_group"
  rgs    = var.rgs
}

module "Vnet" {
  depends_on = [module.rgs]
  source     = "../../module/azurerm_virtual_network"
  Vnet       = var.Vnet
}

module "Subnets" {
  depends_on = [module.Vnet]
  source     = "../../module/azurerm_subnet"
  Subnets    = var.Subnets
}

module "azurerm_PIP" {
  depends_on = [module.rgs]
  source     = "../../module/azurerm_PIP"
  pip        = var.pip
}

module "nsgs" {
  depends_on = [module.rgs]
  source     = "../../module/azurerm_network_security_group"
  nsgs       = var.nsgs
}

module "nics" {
  depends_on = [module.Subnets, module.nsgs]
  source     = "../../module/azurerm_network_interface"
  nics       = var.nics
}

module "vms" {
  depends_on = [module.nics]
  source     = "../../module/azurerm_virtual_machine"
  vms        = var.vms
}

module "bastions" {
  depends_on = [module.Subnets, module.azurerm_PIP]
  source     = "../../module/azurerm_bastion_host"
  bastions   = var.bastions
}