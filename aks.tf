#AKS Subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = "AKSSubnet"
  resource_group_name  = data.azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.10.8.0/22"]
}

resource "azurerm_kubernetes_cluster" "aks" {
    name = "jfoods-aks-dev"
    location = var.location
    resource_group_name = data.azurerm_resource_group.myrg.name
    dns_prefix = "jfoods-aks-dev"

    role_based_access_control_enabled = true

    oidc_issuer_enabled   = true
    workload_identity_enabled = true

    identity {
        type = "SystemAssigned"
    } 

    default_node_pool {
        name = "system"
        node_count = 2
        vm_size = "Standard_D2s_v3"
        vnet_subnet_id = azurerm_subnet.aks_subnet.id

        type = "VirtualMachineScaleSets"

        upgrade_settings {
        drain_timeout_in_minutes      = 0
        max_surge                     = "10%"
        node_soak_duration_in_minutes = 0
        }
    }

    web_app_routing {
        default_nginx_controller = "External"
        dns_zone_ids             = []
    }

    
    network_profile {
        network_plugin  = "azure"
        network_plugin_mode = "overlay"

        pod_cidr = "10.244.0.0/16"
        service_cidr = "10.20.0.0/16"
        dns_service_ip = "10.20.0.10"

        load_balancer_sku = "standard"  
    }
}
