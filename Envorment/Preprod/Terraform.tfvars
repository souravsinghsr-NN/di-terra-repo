rgs = {
  rgs1 = {
    name     = "RG_SK"
    location = "australiaeast"
  }
  rgs2 = {
    name     = "RG_SK2"
    location = "australiaeast"
  }
}

Vnet = {
  Vnet1 = {
    vnet_name     = "Vnet_sk"
    vnet_location = "australiaeast"
    rg_name       = "RG_SK"
    address_space = ["10.0.0.0/16"]
  }
}

Subnets = {
  Subnet1 = {
    subnet_name      = "Subnet1"
    rg_name          = "RG_SK"
    Vnet_name        = "Vnet_sk"
    address_prefixes = ["10.0.1.0/24"]
  }
  Subnet2 = {
    subnet_name      = "Subnet2"
    rg_name          = "RG_SK"
    Vnet_name        = "Vnet_sk"
    address_prefixes = ["10.0.2.0/24"]
  }
  Subnet_bastion = {
    subnet_name      = "AzureBastionSubnet"
    rg_name          = "RG_SK"
    Vnet_name        = "Vnet_sk"
    address_prefixes = ["10.0.3.0/26"]
  }
}

pip = {
  pip1 = {
    pip_name = "pip1"
    rg_name  = "RG_SK"
    location = "australiaeast"
    sku      = "Standard"
  }
  pip2 = {
    pip_name = "pip2"
    rg_name  = "RG_SK"
    location = "australiaeast"
    sku      = "Standard"
  }
  pip_bastion = {
    pip_name = "pip-bastion"
    rg_name  = "RG_SK"
    location = "australiaeast"
    sku      = "Standard"
  }
}

nsgs = {
  nsg1 = {
    nsg_name = "nsg-preprod"
    rg_name  = "RG_SK"
    location = "australiaeast"
    security_rules = [
      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

nics = {
  nic1 = {
    nic_name    = "nic-vm1"
    rg_name     = "RG_SK"
    location    = "australiaeast"
    vnet_name   = "Vnet_sk"
    subnet_name = "Subnet1"
    nsg_name    = "nsg-preprod"
  }
  nic2 = {
    nic_name    = "nic-vm2"
    rg_name     = "RG_SK"
    location    = "australiaeast"
    vnet_name   = "Vnet_sk"
    subnet_name = "Subnet2"
    nsg_name    = "nsg-preprod"
  }
}

vms = {
  vm1 = {
    vm_name        = "vm-linux-1"
    rg_name        = "RG_SK"
    location       = "australiaeast"
    nic_name       = "nic-vm1"
    size           = "Standard_B1s"
    admin_username = "azureuser"
    admin_password = "Password@123456"
  }
  vm2 = {
    vm_name        = "vm-linux-2"
    rg_name        = "RG_SK"
    location       = "australiaeast"
    nic_name       = "nic-vm2"
    size           = "Standard_B1s"
    admin_username = "azureuser"
    admin_password = "Password@123456"
  }
}

bastions = {
  bastion1 = {
    bastion_name = "bastion-preprod"
    rg_name      = "RG_SK"
    location     = "australiaeast"
    vnet_name    = "Vnet_sk"
    pip_name     = "pip-bastion"
  }
}