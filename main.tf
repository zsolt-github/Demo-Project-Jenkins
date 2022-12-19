resource "azurerm_resource_group" "azure-jenkins-rg" {
  location = var.az_location
  name     = var.az_resource_group_name
  
  tags = {
    "ResourceType" = "Resrouce Group"
    "Evironment"   = var.az_tag_environment
  }
}


resource "azurerm_virtual_network" "azure-jenkins-vnet" {
  name                = var.az_virtual_network_name
  resource_group_name = var.az_resource_group_name
  location            = var.az_location
  address_space       = [var.az_virtual_network_address_space]
  depends_on          = [azurerm_resource_group.azure-jenkins-rg]

  tags = {
    "ResourceType" = "Virtual Network"
    "Environment"  = var.az_tag_environment
  }  
}


resource "azurerm_subnet" "azure-subnet-1" {
  name                 = var.az_subnet_1_name
  resource_group_name  = var.az_resource_group_name
  virtual_network_name = var.az_virtual_network_name
  address_prefixes     = [var.az_subnet_1_address_prefix]
  depends_on           = [azurerm_virtual_network.azure-jenkins-vnet]
}


resource "azurerm_network_security_group" "azure-nsg-1" {
  name                = var.az_nsg_1_name
  location            = var.az_location
  resource_group_name = var.az_resource_group_name
  depends_on          = [azurerm_resource_group.azure-jenkins-rg]

  security_rule {
    name                       = "Inbound - SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Inbound - Jenkins - Port 8080"
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
  depends_on                   = [azurerm_resource_group.azure-jenkins-rg]

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
  depends_on          = [azurerm_subnet.azure-subnet-1, azurerm_public_ip.azure-public_ip-1]

  ip_configuration {
    name                          = "Internal_IP-1"
    primary                       = true
    subnet_id                     = azurerm_subnet.azure-subnet-1.id
    #private_ip_address_allocation = "Dynamic"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.20.1.10"
        
    public_ip_address_id          = azurerm_public_ip.azure-public_ip-1.id
  }

  tags = {
    "ResourceType" = "Network Interface"
    "Environment"  = var.az_tag_environment
  }
}



resource "azurerm_network_interface_security_group_association" "azure-nsg_association-1" {
  network_interface_id      = azurerm_network_interface.azure-net_int-1.id
  network_security_group_id = azurerm_network_security_group.azure-nsg-1.id
}



# Generate random text for a unique storage account name
resource "random_id" "azure-random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.azure-jenkins-rg.name
  }

  byte_length = 8
}


resource "azurerm_storage_account" "azure-storage_account-1" {
  #name                     = "bootdiag${random_id.azure-random_id.hex}"
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

  depends_on               = [azurerm_resource_group.azure-jenkins-rg]

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



#resource "tls_private_key" "ssh_key-1" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}



resource "azurerm_marketplace_agreement" "azure_marketplace-jenkins" {
  publisher = "bitnami"
  offer     = "jenkins"
  plan      = "1-650"
}



resource "azurerm_linux_virtual_machine" "azure-linux_virtual_machine-1" {
  name                = var.az_linux_virtual_machine_1_name
  resource_group_name = var.az_resource_group_name
  location            = var.az_location
  size                = var.az_virtual_machine_1_size
  depends_on          = [azurerm_network_interface.azure-net_int-1, azurerm_storage_account.azure-storage_account-1, azurerm_marketplace_agreement.azure_marketplace-jenkins]
  
  network_interface_ids           = [azurerm_network_interface.azure-net_int-1.id]
  computer_name                   = var.az_linux_virtual_machine_1_computer_name
  admin_username                  = var.az_virtual_machine_1_admin_user_name
  admin_password                  = var.az_virtual_machine_1_admin_user_password
  disable_password_authentication = false

  os_disk {
    name                 = "OSDisk"
    caching              = "ReadWrite"
    storage_account_type = var.az_virtual_machine_1_storage_account_type
  }

  source_image_reference {
    publisher = "bitnami"
    offer     = "jenkins"
    sku       = "1-650"
    version   = "latest"
  }

  plan {
    name      = "1-650"
    product   = "jenkins"
    publisher = "bitnami"
  }

  #admin_ssh_key {
  #  username   = var.az_virtual_machine_1_admin_user_name
  #  public_key = tls_private_key.ssh_key-1.public_key_openssh
    #public_key = file(var.az_linux_virtual_machine_1_public_key)
  #}

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.azure-storage_account-1.primary_blob_endpoint
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    "ResourceType" = "Virtual Machine"
    "Environment"  = var.az_tag_environment
  }
}
