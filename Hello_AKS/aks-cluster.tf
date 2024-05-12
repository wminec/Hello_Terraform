resource "azurerm_kubernetes_cluster" "aks_main" {
    name                            = local.aks_name_main
    location                        = azurerm_resource_group.rg_aks.location
    resource_group_name             = azurerm_resource_group.rg_aks.name
    dns_prefix                      = local.aks_dns-prefix_main
    private_cluster_enabled         = false
    kubernetes_version              = local.aks_version_main
    automatic_channel_upgrade       = local.aks_channel_main
    node_resource_group             = "${local.rg_name}-${local.aks_name_main}"
    oidc_issuer_enabled             = true
    workload_identity_enabled       = true

    default_node_pool {
        name                    = "default"
        node_count              = 1
        min_count               = 1
        max_count               = 3
        vm_size                 = "Standard_D2_v2"
        vnet_subnet_id          = azurerm_subnet.subnet_aks.id
        enable_auto_scaling     = true
        enable_node_public_ip   = true
        type                    = "VirtualMachineScaleSets"
        os_disk_size_gb         = 30

        node_labels = {
            role = "default"
        }
    }

    network_profile {
        network_plugin          = "azure"
        network_policy          = "azure"
        service_cidr            = "10.0.0.0/16"
        dns_service_ip          = "10.0.0.10"
    }

    identity {
        type                    = "UserAssigned"
        identity_ids            = [azurerm_user_assigned_identity.user_aid_aks.id]
    }

    depends_on= [
        azurerm_role_assignment.network_contributor_aks
    ]

    role_based_access_control_enabled = true

    tags = {
        environment = azurerm_resource_group.rg_aks.tags.environment
    }

    lifecycle {
        ignore_changes = [default_node_pool[0].node_count]
    }

    provisioner "local-exec" {
        command = "echo ${self.kube_config_raw} > ./azurek8s"
    }
}