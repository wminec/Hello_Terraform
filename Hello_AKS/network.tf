resource "azurerm_virtual_network" "vn_aks" {
    name                = local.vnet_name
    location            = azurerm_resource_group.rg_aks.location
    resource_group_name = azurerm_resource_group.rg_aks.name
    address_space       = local.vnet_address_space

    tags = {
        environment = azurerm_resource_group.rg_aks.tags.environment
    }
}

resource "azurerm_subnet" "subnet_aks" {
    name                    = local.subnet_name_aks
    resource_group_name     = azurerm_resource_group.rg_aks.name
    virtual_network_name    = azurerm_virtual_network.vn_aks.name
    address_prefixes        = local.subnet_address_prefixes_aks
}

resource "azurerm_subnet" "subnet_application" {
    name                    = local.subnet_name_app
    resource_group_name     = azurerm_resource_group.rg_aks.name
    virtual_network_name    = azurerm_virtual_network.vn_aks.name
    address_prefixes        = local.subnet_address_prefixes_app
}

resource "azurerm_dns_zone" "ingress" {
    name                    = local.dns_name_aks
    resource_group_name     = azurerm_resource_group.rg_aks.name
}

resource "azurerm_dns_a_record" "ingress" {
    name                    = "*.aks"
    zone_name               = azurerm_dns_zone.ingress.name
    resource_group_name     = azurerm_resource_group.rg_aks.name
    ttl                     = 3600
    records                 = [azurerm_public_ip.ingress_nginx_pip.ip_address]
}

resource "azurerm_public_ip" "ingress_nginx_pip" {
    name                    = "ingress-nginx-pip"
    location                = azurerm_resource_group.rg_aks.location
    resource_group_name     = "${local.rg_name}-${local.aks_name_main}"
    allocation_method       = "Static"
    sku                     = "Standard"

    depends_on = [
        azurerm_kubernetes_cluster.aks_main
    ]

    tags = {
        environment = azurerm_resource_group.rg_aks.tags.environment
    }
}

## TODO : Get Public IP with output.tf
