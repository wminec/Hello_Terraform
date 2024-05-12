# Hello_AKS
Deploy Simple AKS Cluster.

## Please fill in the variables in `terraform.tfvars`.
- subscription_id : Azure Subscription ID
- client_id : Azure Application(Client) ID
- tanent_id : Azure Directory(Tanent) ID

and run `terraform apply -var-file="terraform-something.tfvars"`

## Reference |
- [Azure Provider: Authenticating using a Service Principal with Open ID Connect](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_oidc)
- [Terraform .tfvars files: Variables Management with Examples](https://spacelift.io/blog/terraform-tfvars)
- [Create resource dependencies](https://developer.hashicorp.com/terraform/tutorials/configuration-language/dependencies)
- [Terraform: Configuring Kubernetes and Helm providers with a kubeconfig secret from Azure Key vault](https://medium.com/@craglea/terraform-configuring-kubernetes-and-helm-providers-with-a-kubeconfig-secret-from-azure-key-vault-2ad20b5d77c3)
