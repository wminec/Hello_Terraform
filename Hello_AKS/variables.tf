locals {
    location                    = "West US 2"
    rg_name                     = "rg_aks_demo"
    environment                 = "Demo"

    vnet_name                   = "vn_aks_demo"
    vnet_address_space          = ["10.8.0.0/16"]

    subnet_name_aks             = "subnet_aks_demo"
    subnet_address_prefixes_aks = ["10.8.0.0/21"]
    
    subnet_name_app             = "subnet_app_demo"
    subnet_address_prefixes_app = ["10.8.8.0/21"]

    user_aid_name               = "identity_aks_demo"

    aks_name_main               = "aks_demo"
    aks_dns-prefix_main         = "aksdemo"
    aks_version_main            = "1.28.5"
    aks_channel_main            = "stable"

    dns_name_aks                    = "wminec.com"
}

variable "subscription_id" {
    description = "Azure subscription id"
}

variable "client_id" {
    description = "Azure Entra Application(Client) id"
}

variable "tanent_id" {
    description = "Azure Entra Directory(tenant) id"
}

variable "kubeconfigfile" {
    description = "kubeconfig file Path"
}