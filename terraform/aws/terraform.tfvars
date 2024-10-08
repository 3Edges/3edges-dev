#########################################
#      3Edges Cloud Deployment          #
# These Terraform scripts deploy 3Edges #
# In the selected Cloud.                #
#                                       #
# Update the variables below with the   #
# right values for your environment.    #
#                                       #
# copyright 3edges, August 2024         #
#########################################

# The AWS region where resources will be deployed (e.g., ca-west-1)
aws_region = "your-aws-region"

# The AWS access key ID for authentication
aws_access_key_id = "your-aws-access-key-id"

# The AWS secret access key for authentication
aws_secret_access_key = "your-aws-secret-access-key"

# The name of the EKS cluster
eks_cluster = "your-eks-cluster-name"

# IAM role associated with the EKS cluster, used by EKS to manage AWS resources
eks_role = "your-eks-role-name"

# IAM role assigned to the EKS worker nodes (EC2 instances), allowing them to interact with other AWS services
eks_node_role = "your-eks-node-role-name"

# Name of the EKS node group, which defines the group of EC2 instances that will be used as worker nodes
eks_node_group = "your-eks-node-group-name"

# VPC (Virtual Private Cloud) where the EKS cluster is deployed, defining the network environment
eks_vpc = "your-eks-vpc-name"

# Route table associated with the EKS VPC, managing routing of network traffic within the VPC
eks_route_table = "your-eks-route-table-name"

# Security group associated with the EKS cluster, controlling inbound and outbound traffic to the EKS control plane
eks_security_group = "your-eks-security-group-name"

# The Domain name for the 3Edges Deployment (Eg., example.com)
hosted_zone = "your-domain"

# Name of the three edges cluster
cluster_config_config_CLUSTER = "cluster-name"

# Email address from which emails are sent
shared_config_SEND_EMAIL_FROM = "noreply@your-domain.com"

# Name displayed as the sender in emails
shared_config_SEND_EMAIL_FROM_NAME = "Your-email-Name"

# Neo4j database (eg., neo4j+s://<db>)
three_edges_DB_HOST = "your-database-host"

# Database name
three_edges_DB_NAME = "your-database-name"

# Database user
three_edges_DB_USER = "your-database-user"

# Database type (eg., neo4j)
three_edges_DB_TYPE = "your-database-type"

# Database version (eg., v5)
three_edges_DB_VERSION = "your-database-version"

# Database password
three_edges_secret_DB_PASSWORD = "your-database-password"

# Primary admin email address
shared_config_PRIM_ADMIN_EMAIL = "admin@your-domain.com"

# Primary admin password
configuration_config_secret_PRIM_ADMIN_PASS = "your-admin-password"

# 32 character length (alpha-numeric)
shared_secret_OIDC_CLIENT_PWD = "your-oidc-client-passwd"

# The invisible reCAPTCHA V2 key for the React application
ui_secret_REACT_APP_CAPTCHA_V2_INVISIBLE = "your_captcha_v2_invisible"

# The reCAPTCHA V2 key for the React application
ui_secret_REACT_APP_CAPTCHA_V2 = "your_captcha_v2"

# Client ID for Google social authentication
idp_config_SOCIAL_GOOGLE_CLIENT_ID = "your-idp-config-social-google-client-id"

# Manual 3Edges Client API deployment (true or false)
manual_api_deployment = false

# Whether the client provides their own cert (true or false)
use_client_cert = false

# Name of the Kubernetes secret where the cert is stored
client_cert_secret_name = "your-client-cert-secret"

# Path to the cert file provided by the client
client_cert_file = "absolute-path/to/client-cert.pem"

# Path to the private key file provided by the client
client_key_file = "absolute-path/to/client-key.pem"