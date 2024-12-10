# Prompt the user for the region
read -p "Enter the AWS region (e.g., us-east-1): " region

# Prompt the user for the cluster name
read -p "Enter the EKS cluster name: " cluster_name

# Run the AWS CLI command to update the kubeconfig
aws eks update-kubeconfig --region "$region" --name "$cluster_name"

# echo -ne "\nKubeconfig updated for cluster '$cluster_name' in region '$region'."