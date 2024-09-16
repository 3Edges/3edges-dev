#!/bin/bash

# Initialize the Terraform configuration, downloading necessary provider plugins and setting up the backend.
terraform init 

# Formatting the code
terraform fmt

# Validate the Terraform configuration files to ensure they are syntactically valid and internally consistent.
terraform validate

# Plan the infrastructure changes, but exclude resources related to the cluster issuer and certificate.
# These resources are intentionally excluded because they need to be created only after the EKS cluster has been provisioned.
terraform plan -out=tfplan -var='exclude_cluster_issuer=true' -var='exclude_certificate=true'

# Apply the planned infrastructure changes from the previous step. This step is only applied after creating the EKS cluster.
terraform apply tfplan

# Plan the remaining infrastructure changes for post-cluster creation tasks, such as cert-manager and other resources.
terraform plan -out=tfplan

# Apply the planned infrastructure changes from the previous step to complete the remaining setup tasks.
terraform apply tfplan