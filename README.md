# Cloud Adoption Framework for Azure - Terraform module
Azure CAF TF
#Login to Azure using az cli 
az login --use-device-code -o table
# Create Resource Group
az group create -g terraform-resource-group -l eastus
# Create Storage Account
az storage account create -n tfstrgact -g terraform-resource-group -l eastus --sku Standard_LRS
# Create Storage Account Container

az storage container create -n caf-tf-state --account-name tfstrgact


# Create Service Principal for terraform to authnticate to Azure 
az ad sp create-for-rbac --name terraform_service_principle --role Contributor --scopes /subscriptions/726f7691-c568-4361-9d13-07be3aa785f9
#Assign contributor RBAC to service principal
