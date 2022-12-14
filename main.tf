resource "azurerm_resource_group" "aks-rg" {
  location = var.az_location
  name     = var.az_resource_group_name
  
  tags = {
    "ResourceType" = "Resrouce Group"
    "Evironment"   = var.az_tag_environment
  }
}

resource "azurerm_virtual_network" "aks-vnet" {
  name                = var.az_virtual_network_name
  resource_group_name = var.az_resource_group_name
  location            = var.az_location
  address_space       = [var.az_virtual_network_address_space]
  depends_on          = [azurerm_resource_group.aks-rg]

  tags = {
    "ResourceType" = "Virtual Network"
    "Environment"  = var.az_tag_environment
  }  
}

resource "azurerm_subnet" "aks-subnet" {
  name                 = var.az_subnet_1_name
  resource_group_name  = var.az_resource_group_name
  virtual_network_name = var.az_virtual_network_name
  address_prefixes     = [var.az_subnet_1_address_prefix]
  depends_on           = [azurerm_virtual_network.aks-vnet]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "azure-nsg-1" {
  name                = var.az_nsg_1_name
  location            = var.az_location
  resource_group_name = var.az_resource_group_name
  depends_on          = [azurerm_resource_group.azure-rg]

  security_rule {
    name                       = "Inbound - RDP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Inbound - Port 8080"
    priority                   = 111
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "ResourceType" = "Network Security Group"
    "Environment"  = var.az_tag_environment
  }
}



resource "azurerm_public_ip" "azure-public_ip-1" {
  name                         = var.az_public_ip_1_name
  location                     = var.az_location
  resource_group_name          = var.az_resource_group_name
  allocation_method            = var.az_public_ip_1_type
  sku                          = var.az_public_ip_1_sku
  depends_on                   = [azurerm_resource_group.azure-rg]

tags = {
    "ResourceType" = "Public IP"
    "Evironment"   = var.az_tag_environment
  }
}



resource "azurerm_network_interface" "azure-net_int-1" {
  name                = var.az_net_int-1
  location            = var.az_location
  resource_group_name = var.az_resource_group_name
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
  depends_on          = [azurerm_subnet.azure-subnet-1]

  ip_configuration {
    name                          = "Internal_IP-1"
    subnet_id                     = azurerm_subnet.azure-subnet-1.id
    private_ip_address_allocation = "Dynamic"
    # private_ip_address_allocation = "Static"
    # private_ip_address            = "10.10.1.122"
        
    public_ip_address_id          = azurerm_public_ip.azure-public_ip-1.id
  }

  network_security_group_id       = azurerm_network_security_group.azure-nsg-1.id

  tags = {
    "ResourceType" = "Network Interface"
    "Environment"  = var.az_tag_environment
  }
}



resource "azurerm_storage_account" "azure-storage_account-1" {
  name                     = var.az_storage_account_1_name
  resource_group_name      = var.az_resource_group_name
  location                 = var.az_location
  
  account_tier                    = var.az_storage_account_1_account_tier
  account_kind                    = var.az_storage_account_1_kind
  account_replication_type        = var.az_storage_account_1_replication_type
  enable_https_traffic_only       = true
  access_tier                     = var.az_storage_account_1_acces_tier
  # min_tls_version                 = var.az_storage_account_1_min_tls_version
  # allow_nested_items_to_be_public = true

  depends_on               = [azurerm_resource_group.azure-rg]

/*
 network_rules {
    default_action             = "Allow"
    ip_rules                   = ["10.20.1.1"]
    virtual_network_subnet_ids = [azurerm_subnet.az_subnet_1_name.id]
  }
*/

  tags = {
    "ResourceType" = "Storage Account"
    "Evironment"   = var.az_tag_environment
  }
}



resource "azurerm_storage_container" "azure-storage_conainer-1" {
  name                  = var.az_storage_conainer_1_name
  storage_account_name  = var.az_storage_account_1_name
  container_access_type = var.az_storage_container_1_access_type

  depends_on            = [azurerm_storage_account.azure-storage_account-1]
}



resource "azurerm_linux_virtual_machine" "azure-linux_virtual_machine-1" {
  name                = var.az_linux_virtual_machine_1_name
  resource_group_name = var.az_resource_group_name
  location            = var.az_location
  size                = var.az_virtual_machine_1_size
  admin_username      = var.az_virtual_machine_1_admin_user_name
  network_interface_ids = [
    azurerm_network_interface.azure-net_int-1.id,
  ]

  admin_ssh_key {
    username   = var.az_virtual_machine_1_admin_user_name
    public_key = file(var.az_linux_virtual_machine_1_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.az_virtual_machine_1_storage_account_type
  }

  source_image_reference {
    publisher = "bitnami"
    offer     = "jenkins"
    sku       = "1-650"
    version   = "latest"
  }

identity {
    type = "SystemAssigned"
  }

  tags = {
    "ResourceType" = "Virtual Machine"
    "Environment"  = var.az_tag_environment
  }
}


/*

resource "azurerm_windows_virtual_machine" "azure-windows_virtual_machine-1" {
  name                = var.az_windows_virtual_machine_1_name
  resource_group_name = var.az_resource_group_name
  location            = var.az_location
  size                = var.az_virtual_machine_1_size
  admin_username      = var.az_virtual_machine_1_admin_user_name
  admin_password      = var.az_virtual_machine_1_admin_user_password
  network_interface_ids = [
    azurerm_network_interface.azure-net_int-1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.az_virtual_machine_1_storage_account_type
  }

  source_image_reference {
    publisher = "bitnami"
    offer     = "jenkins"
    sku       = "1-650"
    version   = "latest"
  }
  
  identity {
    type = "SystemAssigned"
  }

  tags = {
    "ResourceType" = "Virtual Machine"
    "Environment"  = var.az_tag_environment
  }
}


*/