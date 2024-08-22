#!/bin/bash

cd ./terraform/aws 
terraform init 

terraform validate

# excluding the resources as they need to be created after eks cluster creation
terraform plan -out=tfplan -var='exclude_cluster_issuer=true' -var='exclude_certificate=true'

# terraform apply tfplan -auto-approve
terraform apply tfplan

# post cluster creation (cert-manager, etc)
terraform plan -out=tfplan
terraform apply tfplan

