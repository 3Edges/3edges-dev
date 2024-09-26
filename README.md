# 3Edges Deployment

This repository contains Terraform scripts to deploy the 3Edges software across cloud provider. These scripts automate the infrastructure setup, ensuring a seamless deployment process of 3Edges into your cloud environment. 

## Features
- Automated Cloud Infrastructure: Deploys and configures cloud resources for 3Edges, such as VPCs, load balancers, Kubernetes clusters, databases, and more. 

- Scalable and Secure: Includes cloud-native best practices for security, scalability, and reliability.

- Easy Configuration: Customize settings like region, cluster names, and database credentials through a simple configuration file (terraform.tfvars).

## Customization
You can modify various settings, just to name a few:
- Cluster names
- Database configurations
- Networking settings
- Admin emails and passwords

These can be set in the ```terraform.tfvars file```

## Deployment Document 

[AWS](terraform/aws/README.md)